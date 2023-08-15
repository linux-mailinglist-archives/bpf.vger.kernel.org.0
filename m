Return-Path: <bpf+bounces-7793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF57B77C73A
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 07:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FFE281277
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 05:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5572D5241;
	Tue, 15 Aug 2023 05:50:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6C3C27
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 05:50:09 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B91093
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 22:50:07 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6471e071996so8591486d6.0
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 22:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692078606; x=1692683406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfdjWdLKQMb5IEQZB2WlBvuvkfFSWys0eEHTgFdjMj8=;
        b=AvTc/xnmF6PhX90DCX3bETII3xc0GsieRQ1EFAef7/u87oZ1mWtgMj+a93FwRQRs+z
         vNzwS5WYlvx9Vy4LfssoJK9N/yMJDmhuMhiq7DEPhIrZKI8QNYYGAOeoEN+0jMyq52q6
         AXwc3kZkQ423t6tLeeBrUxh9zf6aEzOUz8V8mskQ+A3VC+A/3nEzdkHHVkxhmQw9xbRh
         WNkACZ51MlTBbPgE8hYCBeuPYipNyvGxPxfZy1WGbbJLXUsA1RyP4NofXgznkZ3mkeX6
         TxugmMCVZGbfQHXx5hzdKIm/nkMIPKQu+OzK26QB5JELvQ+0yGimS2SAQYYVH5EuCb7k
         YW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692078606; x=1692683406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfdjWdLKQMb5IEQZB2WlBvuvkfFSWys0eEHTgFdjMj8=;
        b=J1bc3Ag0fJSXEImxUHAUbTdMpLcmUTdqOeqmhyNDLRqDIiWvqBhVcFAe6QbRnnMFvy
         8SE7UvA0nbUr41FQ3ULudxbjNSYdTakE79n8pj0XyBS1sAGdddee0YiFfAlwPQKsp9wC
         aGOGxEse3Bp6nsDbKE7gdSzBL8VY0LslECw1lgpYvF9VCBGOwCH/OTdTuxmLCMfW3/kU
         R5kvC+y/jtzPovPyGVnZSwdvd0eOLabNPTVwB88cKGThnojjRVpk+sErQzWK116/uvpJ
         hXAPnay+KJ6bkgxZCcIi2pX5WPhAmvDYjT6l+Vp33AcH5uPPNYwEGAENx10ryxFmxmcj
         HzZA==
X-Gm-Message-State: AOJu0YwLZ8KE3+3Enb6jYiET8RvH307LO71OWGc8FnOACitAsxEsTkA8
	NR/eN89WJcRfYZ5aBYRJbt4K/L8PfgXeGBu8saQ=
X-Google-Smtp-Source: AGHT+IEq5xjPzx+Eq+OStitdXGBJOiZ5oRSWstCh4KC35dbj9PqRWwru2nWvANcVZo+wLxD9WGm2Rzg11ehgSkqcvcQ=
X-Received: by 2002:a0c:c345:0:b0:63f:5e4a:eaa0 with SMTP id
 j5-20020a0cc345000000b0063f5e4aeaa0mr12504608qvi.53.1692078606603; Mon, 14
 Aug 2023 22:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814143341.3767-1-laoar.shao@gmail.com> <20230814143341.3767-2-laoar.shao@gmail.com>
 <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev> <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
 <39dfc028-1dc7-286b-57e6-271ca588bd68@linux.dev>
In-Reply-To: <39dfc028-1dc7-286b-57e6-271ca588bd68@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 15 Aug 2023 13:49:30 +0800
Message-ID: <CALOAHbAqVLjQ+M+GCwywN3WeCSD=Hjx+GcBgtSC6Ws0Ef6x6Tw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
To: yonghong.song@linux.dev
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 11:40=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
>
> On 8/14/23 7:45 PM, Yafang Shao wrote:
> > On Tue, Aug 15, 2023 at 8:28=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >>
> >>
> >> On 8/14/23 7:33 AM, Yafang Shao wrote:
> >>> Add a new bpf_current_capable kfunc to check whether the current task
> >>> has a specific capability. In our use case, we will use it in a lsm b=
pf
> >>> program to help identify if the user operation is permitted.
> >>>
> >>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>> ---
> >>>    kernel/bpf/helpers.c | 6 ++++++
> >>>    1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >>> index eb91cae..bbee7ea 100644
> >>> --- a/kernel/bpf/helpers.c
> >>> +++ b/kernel/bpf/helpers.c
> >>> @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
> >>>        rcu_read_unlock();
> >>>    }
> >>>
> >>> +__bpf_kfunc bool bpf_current_capable(int cap)
> >>> +{
> >>> +     return has_capability(current, cap);
> >>> +}
> >>
> >> Since you are testing against 'current' capabilities, I assume
> >> that the context should be process. Otherwise, you are testing
> >> against random task which does not make much sense.
> >
> > It is in the process context.
> >
> >>
> >> Since you are testing against 'current' cap, and if the capability
> >> for that task is stable, you do not need this kfunc.
> >> You can test cap in user space and pass it into the bpf program.
> >>
> >> But if the cap for your process may change in the middle of
> >> run, then you indeed need bpf prog to test capability in real time.
> >> Is this your use case and could you describe in in more detail?
> >
> > After we convert the capability of our networking bpf program from
> > CAP_SYS_ADMIN to CAP_BPF+CAP_NET_ADMIN to enhance the security, we
> > encountered the "pointer comparison prohibited" error, because
>
> Could you give a reproducible test case for this verifier failure
> with CAP_BPF+CAP_NET_ADMIN capability? Is this due to packet pointer
> or something else? Maybe verifier needs to be improved in these
> cases without violating the promise of allow_ptr_leaks?

Here it is.

SEC("cls-ingress")
int ingress(struct __sk_buff *skb)
{
        struct iphdr *iph =3D (void *)(long)skb->data + sizeof(struct ethhd=
r);

        if ((long)(iph + 1) > (long)skb->data_end)
                return TC_ACT_STOLEN;
        return TC_ACT_OK;
}

In this bpf prog, it will compare the pointer iph with skb->data_end,
and thus it will fail the verifier.

--=20
Regards
Yafang

