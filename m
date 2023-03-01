Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3F66A6782
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 07:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCAGEp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 01:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCAGEo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 01:04:44 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E8337F00
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 22:04:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cq23so49556750edb.1
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 22:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pk4/og4wLlHaOAC2KiY1954i3PNRitxXkE8E9mQ1I/E=;
        b=UGaYkuYwoi0pElUzuDSeQ0Oj6lJCbIlgGBBP0mzdICEuLSOsxXzcClmuEwPHaK8m16
         0seKZgBTrgBsw5d6RaG19ui2sMjuucaxtZmexglyTLDAT42eGd658sA8ALrljB8z9MQR
         fip4XadVkiSqgDa6IWeX9DdHwuZQcVw3u5l1ysBsa0K6ecr1tG8ynoRSdkUFXs6hQTlU
         4J1fOLrU/gV8FTglqYmuoG7uh47bTQF/yQwXSDOGLWw/eSOxZsh2WyJYBigPt4ge+WtE
         GsHqNMkFCddGVK0gBz6Rfw0t/s7+NWkXQUp1SixZzDTCKJlNtmt/wAV3/MGObjkhLjlQ
         1xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pk4/og4wLlHaOAC2KiY1954i3PNRitxXkE8E9mQ1I/E=;
        b=nNVluZ4S7dqhVypk6b6i3EUNKIj50nYjIpmppl67pmyW/kXEIZ9/hx8LcyknnVZlgN
         Dz6ZIavhxTVC0p/dherwtFYZcaRWWGPMz/o+yCg/l+RVtmmvNFracCcywrHZci9355aZ
         63JyNAdXzbM20akCiUODx68gbr3kqEofnLSb9kjTasUQ7afFYheC0HUQvwI6Q2yTf1aY
         Wey/qys+GkzZ6dKP3FYYXvJttgiGSwSkkuRzqb7k5TvZisIaNHQ06vyTuyZI0Sz2s14B
         OgaBCf8YrJRkzJIEiwbpO6DhWkJ7i7FfWjoPX+u7+R8pALGyNBoOMRLdzxiPv43tJ2LB
         MErw==
X-Gm-Message-State: AO0yUKUe7qihGWELwJh83w3XNc5XG25NRFCNZWFFnNdGe4GMHdJ2nxV/
        3YCi62yges5icAtk06Jgyo53uyzz/MUX7sTgdgO8zW22
X-Google-Smtp-Source: AK7set+TSQ5hEO7xBiyDHisJMaZrOhMtXsO0vctOIZDPxlSKxSaXduej8jvJAABxGvUSbZgcw3B++1CbwDBNxx2L38E=
X-Received: by 2002:a17:906:d789:b0:8ae:9f1e:a1c5 with SMTP id
 pj9-20020a170906d78900b008ae9f1ea1c5mr2513329ejb.3.1677650682137; Tue, 28 Feb
 2023 22:04:42 -0800 (PST)
MIME-Version: 1.0
References: <0838bc96-c8a8-c326-a8f0-80240cf6b31a@linux.intel.com>
 <CAADnVQJ4fHzqeuhbCF5SDR5V1Ktku=U2RRRPLc17ia0aFgNG=w@mail.gmail.com>
 <f171f10b-f7e5-e63d-b446-b37a2856909a@linux.intel.com> <CAADnVQKQ+eEyNt_3EsNkCbxgu93tNEOFq+EGs-6JJhMt-A50cA@mail.gmail.com>
 <73557717-e0b2-3969-4f08-c0951361af45@linux.intel.com>
In-Reply-To: <73557717-e0b2-3969-4f08-c0951361af45@linux.intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 28 Feb 2023 22:04:30 -0800
Message-ID: <CAADnVQ+sB+9Q7axoktd5BqW-82X18Sg2E-obEPDtmk0qphymKA@mail.gmail.com>
Subject: Re: bpf: RFC for platform specific BPF helper addition
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 28, 2023 at 1:45=E2=80=AFAM Tero Kristo <tero.kristo@linux.inte=
l.com> wrote:
> >>> Make sure to add selftests when you submit a patch.
> Regarding this I got a follow up question, where would you recommend to
> put selftests for such functionality? Any of the BPF selftests appear to
> be generic currently.

There are arch specific selftests.
They can be skipped on other archs either via DENYLIST or at runtime.
