Return-Path: <bpf+bounces-3496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA4273ED06
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 23:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074A81C20A02
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 21:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF3D154AA;
	Mon, 26 Jun 2023 21:45:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F35E15487
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:45:05 +0000 (UTC)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABA01702
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 14:45:03 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4021451a4a4so1512151cf.0
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1687815902; x=1690407902;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kIgnFlgU5RvYwp8yBfRZFIU2hbP9qmLa4tozrqcWODU=;
        b=G+9VIizx7Nk9Q/oyUWn05wUyeisbDhr8+GnykF85+xdQyTw57iblXyMow25E78gjO1
         5RT0+kJ0MXoxFGOViKwiulDz+iLSxR0xqRFJSX6CJ3AUyZS5wI+2xY4fUNFkaJxebneY
         itmNh1Yb3ihd/HRDzhphQ6mN1k2D6ipknC42E2B9wbBdT4rQGSajdK7qKpsEbW+Ke53n
         72h12x4peXT521JJH69vgUXBlkoHfb2DV6wfhMuIMveAPwhH7szurFVhKxjQYxMwe3H6
         3mL1+Clarw1SmVgn4Pw9/1q5Eb1OE5hZwTx0knGUXM/FnezOWB2ZzxdAIbBc4QdbpdGL
         G8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687815902; x=1690407902;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIgnFlgU5RvYwp8yBfRZFIU2hbP9qmLa4tozrqcWODU=;
        b=ER5wXzPGfBs3MAUvA0ZuHb+FzXNfq3SCDWqiw5+vozYYtzRgejR5e/DzN4PwXdyIOi
         xBxCiUZ93/+x28zzRueKHVvQroazlbS6gE73OyXo1Qn5aBiLg74P1foIHBxgYrBhzdDr
         BT3fvM96wT35rQzCGNwegssRw5+r1nHdI6ezEADZg3iPmM9CKEURAzKNGajrAMOE1B1T
         HLjO34i+YER6kN4oFOe0S2UUFMhQR4vXfZVpyvmOtg7rpBHWxjEpQ7TK7sTkbMlTQc9u
         yQvDKwrkDV/GzgDwkPWq1K3o7CQyqp41tSMVXvBoQSfmrRAhuyZ0/z5C3r5CsaMd1yX6
         Pbew==
X-Gm-Message-State: AC+VfDx+thI4lMQ7ldIZMFWXSCraSXixNz3co0y61UcUBLQJ31x0cuCR
	yLrEaNnyLShjEeVczCmFQ+wDXTX4jXj1YKH5xE4VaqHj+TcSliP/iQc=
X-Google-Smtp-Source: ACHHUZ5YdmXbR5QvUtiUqhuf6/SUbJ0hpBcBhPac70Fc/PfkFHp6Se70jjfsfZDS+q+RFG9Mas4EGqkMvEDe+dxr3Ok=
X-Received: by 2002:a05:6214:508c:b0:625:aa1a:b6db with SMTP id
 kk12-20020a056214508c00b00625aa1ab6dbmr33024686qvb.61.1687815902279; Mon, 26
 Jun 2023 14:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 26 Jun 2023 17:44:51 -0400
Message-ID: <CADx9qWgHCC4MML2d+mq25-aeTn+20qxjeTZSHMGPQrMq65a+bQ@mail.gmail.com>
Subject: [RFC] Interest in additional endianness documentation
To: bpf@vger.kernel.org, "jemarch@gnu.org" <jemarch@gnu.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello all!

Thank you to everyone in the community for building/working on such a
great tool! I am helping build a userspace implementation of eBPF and
following Dave's standardization process closely.

I was investigating how endianness affects the order of the components
of instructions in memory. In particular, the order of the src/dest
fields. In the IETF mailing list archives I found Jose's excellent
pointer to the implementation-defined nature of the order of bit
fields (https://mailarchive.ietf.org/arch/msg/bpf/I7abyqaiXj_DYuoLln5joMw90k0/)
and spent the better part of today digging through gcc's source code
to find the *actual* logic that controls the order (yes, I believe
that I ultimately found it!).

Nevertheless, given that there is a reliance on the behavior of gcc
and clang, would you be interested in having additional documentation
about it? I would love to write it but don't want to waste your time.
I was thinking:

1. Adding documentation about field order to include/uapi/linux/bpf.h
where the insn struct is defined.
2. Adding documentation to the design QA (Documentation/bpf/bpf_design_QA.rst)
3. Anything else that others might want.

I apologize for the long email and I just want to be helpful. If this
seems worthwhile, please let me know. Otherwise, I will defer and not
bother you all further.

Thanks!
Will

