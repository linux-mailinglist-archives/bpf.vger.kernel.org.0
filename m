Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC4065F9E1
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 04:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjAFDDU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 22:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjAFDCg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 22:02:36 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF9B6CFD6;
        Thu,  5 Jan 2023 19:01:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id u19so864190ejm.8;
        Thu, 05 Jan 2023 19:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVcc+AxLpCmQrlskmey4vC08mDyFoGGH7C3hKYNnPeU=;
        b=KyBwqA61hhb573NY68anN4JJhf/FDP6mtESP9g8HKfZDbLob0CXE58tJ7D72qlUF/I
         ZeOlr0JSH7cYqiZA5aBujlP2AgDlJsk47vUpp2JzgBL8BdIa0QRWFmLRvIEIUNfe4gy6
         o74DcelkHmrAN22CqGmPE9FJGemnmdFx9uChqSVlu2zeQb6aSuA1t7DlKNtJZbE/d3O/
         PV3UPuttuaN79iGBCFikgreqiH/ROAj57x8/G7xjlDoxSRMKUHTkOBGpsW4nEIgZDPhc
         bST+VVu152lvvY5HXy0r6cDRQv2evCGjJIjGFwl8fSjdsm5Y6Ji/ymwSPxah9D9LU4Ou
         RYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVcc+AxLpCmQrlskmey4vC08mDyFoGGH7C3hKYNnPeU=;
        b=IFPYUFG2fwVko7sckKwFdGbVgQrzo2P21MQTsZ3QR5wWHC0EUT5URTKwWuV+SgJ12+
         uCtdbhysKfHbWUXhmFkW1jY6sisEmTjDGC0U1MaNrwIsJasOfvedVZxGZ1ZPU2ZYMUtX
         vRSm7KJxPwue6jh2lXZH8+E+fzKzdDhGmuC3uR4UcpgBLHX2T2y+WgYJAzsbX8c7Ur0g
         StRgEPgTdny84nHjLe/MzFpoB91kn4VapMYN05M4BZa8eMr1Opz/GBaltp61mlSuqtIr
         LK9+jGcPpGW6t73pgbs8mCQMXyP2L/7CW6zVihEa+vVwbk8k+G2Z1zn7lQGNPj1BJi18
         g/7g==
X-Gm-Message-State: AFqh2krNoPo2i7yZLlmuyXjZNd7qWH57+PjDUfmd2azdGCALRBrXr4aj
        0lHwHYNQGSp2221UgTT6inF1xpj+luifwlBNTvY=
X-Google-Smtp-Source: AMrXdXtD/C50xIj69PIBAAAiCwaJUZqAb3iIigVRXQwB0u0HQGZ6rKr0z0kWnqgii5JAdCZw/aoNaGqC7odblE8kwGU=
X-Received: by 2002:a17:906:dcf:b0:7c1:6781:9c97 with SMTP id
 p15-20020a1709060dcf00b007c167819c97mr3806934eji.676.1672974094765; Thu, 05
 Jan 2023 19:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20221222043507.33037-1-sunhao.th@gmail.com> <ef46c1f6-0939-c2ed-3efb-c3c5f28d1931@meta.com>
 <73E3CA9E-F67E-429F-A2DB-C77649E32D7A@gmail.com> <CAADnVQ+EMzAmeKvivFKvqCNj6H9X-1rBtBBnjRzDiNvkocsc6A@mail.gmail.com>
 <2EC740FA-A10B-4208-8080-9A268BD8E675@gmail.com> <CAADnVQKzRS6HcbOPuJRJ=8SOXDDDdy2EBN-LP6vSgB9tLb27Ug@mail.gmail.com>
 <F6713293-7B1E-4C2B-8B6F-683A1B3E002D@gmail.com>
In-Reply-To: <F6713293-7B1E-4C2B-8B6F-683A1B3E002D@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 5 Jan 2023 19:01:23 -0800
Message-ID: <CAADnVQ+1F-vZNr5d38hdQwnyR0Vq9qXW_1YMprQMLHKwrPk3SA@mail.gmail.com>
Subject: Re: kernel panic: Attempted to kill init!
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jan 5, 2023 at 1:00 AM Hao Sun <sunhao.th@gmail.com> wrote:
> >
> > Does syzbot running without any user space?
> > Is syzbot itself a pid=3D1 ? and the only process ?
> > If so, the error would makes sense.
>
> Yes, after read the C reproducer again, noticed that after a
> bunch of sandbox setup, the pid of the reproducer process at
> runtime is 1.
>
> > I guess we can add a safety check to bpf_send_signal_common
> > to prevent syzbot from killing itself.
>
> Maybe something like this? This can avoid the panic, but won=E2=80=99t
> allow task with pid=3D1 to send signal with prog.
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 23ce498bca97..94d2af2ce433 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -844,6 +844,8 @@ static int bpf_send_signal_common(u32 sig, enum pid_t=
ype type)
>          */
>         if (unlikely(current->flags & (PF_KTHREAD | PF_EXITING)))
>                 return -EPERM;
> +       if (unlikely(is_global_init(current)))
> +               return -EPERM;
>         if (unlikely(!nmi_uaccess_okay()))
>                 return -EPERM;

Yep. Good idea. Pls send an official patch.
