Return-Path: <bpf+bounces-6886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098FD76F14F
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 20:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300F31C215DA
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 18:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810002517A;
	Thu,  3 Aug 2023 18:03:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E51F16D
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 18:03:33 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120B349F8
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 11:03:10 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-635f293884cso7556816d6.3
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691085777; x=1691690577;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rAq2YrG+azV8Ueq6huyg+StqMdELqbivnNJUlDy0Ue4=;
        b=gAcNsTQaxhp6uB8Nt/wVO+B0jxOtfwCy2ZuFHrZajiGUHJnJdK0NKTCkGbf+ADIViO
         dRJiUhvXcEYnURopnoTseQdFerluoEDTY6KfcxY+fegbU7AVwY+AQncKaFSbD70T53Bs
         g2SkA8t8td9MxtiojO+gCUyidjMSkrohYk2hBmPzZODqiuLc9bUg71Di79eARopqlKDm
         MDGhCR1hGelRGRQ4Wt0ZEEZ2s2tpbYkOj0Yk+XNPJWO/72F8aevhQmUAdv/enQPWtWdr
         kjkY/u0pPOcIMWXWc6YEcJMulfaVL9Ryb2XUVZfJLQa6KIrffKrFW0AiYXc0WZ93bUda
         DK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085777; x=1691690577;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rAq2YrG+azV8Ueq6huyg+StqMdELqbivnNJUlDy0Ue4=;
        b=KscAxjNb6TVp1ZPu/aAejGNlXN4Wod3mcdE9ogvgKDh/Cj5LzwqzSccIDxEO/O6a2D
         50H9TOfd2A2p/eFktvfA4qlXDXPhGEZZ95181xeCOumDlxqdiHCMOkut08hZJJwv6tCT
         iEMHoNuEMexCYNtp1TcSKM9WFfLmi3yj9Pkz9oAIixdu/MrPbTb3+fPToxaLhvfZOIA8
         s2evQP2SECjZm1nCnkHIFkP69ZPXTH3loV7uQNu/CNvEBuDviWoN51BqJE4AkQyPXpep
         32p/gyyF80ZnNdjeG+g6hExfeH2IcIf20olD+0S31SH/DwV9jFsvcGsr04BAXXARwaaD
         1RxQ==
X-Gm-Message-State: ABy/qLaXiolsWoWlMylPHh1xja4qWTkwg3ZJvmpIk4V0N6RqGHSBNQv/
	JW/Sc+/aNSxd2tDAnQNuCcsryqu+cx7uP+iI9u7U2BfRYhGewjArvQjjUQ==
X-Google-Smtp-Source: APBJJlELyYpReSpW4PcwV/6/Rm8KiR7KXc8zKl/PONXDsmGCrMVmWCue5OZMKdkCAO4H3aibnMTaF6nGh1Pcy2mAmMc=
X-Received: by 2002:ad4:4b2d:0:b0:63c:62fa:745b with SMTP id
 s13-20020ad44b2d000000b0063c62fa745bmr17265920qvw.8.1691085777443; Thu, 03
 Aug 2023 11:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 3 Aug 2023 11:02:46 -0700
Message-ID: <CAKwvOdm9PqNBLSZa_t5b=15cdtKvKq4q8WZr3i77W66m4FRAAQ@mail.gmail.com>
Subject: FAILED: load BTF from vmlinux: Invalid argument
To: martin.lau@linux.dev
Cc: bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	=?UTF-8?Q?Tomasz_Pawe=C5=82_Gajc?= <tpgxyz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Martin (and BTF/BPF team),
I've observed 2 user reports with the error from the subject of this email.
https://github.com/ClangBuiltLinux/linux/issues/1825
https://bbs.archlinux.org/viewtopic.php?id=284177

Any chance you could take a look at these reports and help us figure
out what's going wrong here?  Nathan and I haven't been able to
reproduce, but this seems to be affecting OpenMandriva (and Tomasz).

Sounds like perhaps llvm-objcopy vs gnu objcopy might be a relevant detail?
-- 
Thanks,
~Nick Desaulniers

