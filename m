Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5072867CD5D
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 15:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjAZOQD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 09:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjAZOQC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 09:16:02 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9CC4109D
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 06:16:00 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id d3so1299365qte.8
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 06:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8ZYk9GcseE/ZRohazUXz6bjLnoVlM/jG7+WX+sNkI0=;
        b=d+g5uld+FMRZ9jlpWI7Tio9bwORnksF/bH7CD2cHcN7uekR7BvQy/KkWri03TQwjFO
         saLGnC0S1E09uIX3ASEM/im7ulbDTP57vc6r/dczH7vylezt4TdpWWvrY0Er+Zp1iIHj
         /NGQuxT8oYU5hDoMNicKx8KOlumQd4pPu/+KoRKeSkKJBYcB4rB7Gy30dAaTFuReyW7Z
         zbZkU2c81nGFDWT14Cif5+DG0ka81+2Dsy08v8FMp+H8ORnMkh0BurMx7kS85vghSc4X
         Mft0GlAK1XK2Y2Y4KgfyXitCxCl9y5pprcFD63BM8Kks8Xo/pTi+6nxffC82pYFzC3Ah
         Q5dw==
X-Gm-Message-State: AFqh2koUMyyvB0ojTLOwju9d52hZoWPCkjx5LUwziFcjJkmL+Rq6SEoJ
        ISfYp1jYJFVrKajbgEB3BlaEJseYsOPenmHJ
X-Google-Smtp-Source: AMrXdXvn8Br5D2U4B9PqfJKMZ97uRBPvqKIiVmI96pPGGMuxqjMD7rQv4X1Wcfbb58PmkXrwn9G2Tg==
X-Received: by 2002:ac8:5a95:0:b0:3b6:3b1e:e8e4 with SMTP id c21-20020ac85a95000000b003b63b1ee8e4mr66305557qtc.27.1674742559367;
        Thu, 26 Jan 2023 06:15:59 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id e11-20020ac8414b000000b003b63c08a888sm835930qtm.4.2023.01.26.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:15:58 -0800 (PST)
Date:   Thu, 26 Jan 2023 08:15:57 -0600
From:   David Vernet <void@manifault.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Multi-kfunc sets / restricted scoping
Message-ID: <Y9KLHZ1TNXVHdVKm@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

I would like to propose discussing a potential new kfunc-related feature
at LSF/MM/BPF: Enabling kfuncs to be restricted to only being callable
from a subset of specific BPF programs, e.g. from only a subset of
callbacks defined in a struct_ops struct, rather than from any
struct_ops program.

Some kfuncs may not be safe or logical to call from all contexts. For
example, the backend kernel implementation which is invoking a
struct_ops callback may set some global state before calling into BPF,
and may thus expect that the state is set when the program calls back
into the kernel from that struct_ops callback, via a kfunc. If the kfunc
can't actually rely on that expectation, whether for safety reasons or
correctness reasons, it has to implement its own methodology for
ensuring it was called from the right context.

Providing developers with an ability to specify the specific programs
that a kfunc should be invokable from would address this problem, and
would avoid every kfunc implementation from having to implement its own
scope checking / validation where required.

I would like to discuss possible design approaches, UX approaches, etc.

Thoughts?

Thanks,
David
