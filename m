Return-Path: <bpf+bounces-8816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5091A78A39C
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 02:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8D3280E07
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 00:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A754814A8B;
	Mon, 28 Aug 2023 00:02:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A314A8A
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 00:02:00 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B44113
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 17:01:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c136ee106so332050666b.1
        for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693180899; x=1693785699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YeJDHt5xgWIdby+zyKiBeFvlmLkuZZjTKjZ++25fXPE=;
        b=q1RpOcKYq+4uvayAwG462eJWva0wAykfmMZjmqKUbJPFwhhm1Gb6kckFfFb95AFL0m
         BZsFr9+3uKbTPcuJglX5k9+8SkTDsgJPOepi5Qn1HjWMfRcaDZ3cxQPIw273YyuotbLG
         llGg6A6vC5P6mjQXn03Exv8UXohgPoHMMPnM4vrND6HaSzpyBrJnZ8OEK3sC/MaI2SM7
         /oREKcPqb6eCvz/bRoLeXeNLnvtuPhX6vlunb6zHBeWQSpordpHF4E2QyQ3Dxy1tVF2Y
         wWfPy25l3zU+4uwLrBJvCDhd/jM9Wd+hH1EYgcRM85wePh2zovyIXuGim4kYMqYzUbt4
         Q8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693180899; x=1693785699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YeJDHt5xgWIdby+zyKiBeFvlmLkuZZjTKjZ++25fXPE=;
        b=TeBTGXdz3Xq14b95iNp8lh6jMr6amE9uYkMzFJ1W87+hKMlmXbh3scyNga5GOB1aMu
         EPtLWeII+uAN8af7seZYR1QmAFFx1Xh6e6brqcbnrMlkVnj5HzG9+dwlcd6bRuC09cDV
         ML2Zeq6mzMS8yZfUZAEfPE0RF5RTh5QtVIq4Sp1zk/HOmjhgg0r2eLKLlCbTd8dDCyBX
         L5/XxvOryAhPtX4Nui6lDTzV7v2v0dXkKJ/6TgdU/GpJRDG3LL1L7Ah2GIpwo0rlOCQx
         l/wPYARitRJu6Vopsuwg6ulXwIDt7A9DbqJT258abTycfc9lzWE1RilsjpyYTTGY+sFt
         +pRQ==
X-Gm-Message-State: AOJu0YxaljuqTtRLCw/slI0ghGandGQlhTqZnEYIKEguLUdwGaOaeqpJ
	QhBHOYcohXCANnNg5/Do3H4=
X-Google-Smtp-Source: AGHT+IHKd0ocCSEGFu97YeUBEXACjUQRd7EdJ5wWs6gm8BXhvxx/1qENZZ+oAOKypgm4j01ecouTqw==
X-Received: by 2002:a17:906:3018:b0:99e:6a0:5f64 with SMTP id 24-20020a170906301800b0099e06a05f64mr19100586ejz.36.1693180898597;
        Sun, 27 Aug 2023 17:01:38 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906434900b0097404f4a124sm3916514ejm.2.2023.08.27.17.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 17:01:38 -0700 (PDT)
Message-ID: <3d7a51e99b545c28eb386218cc9c4f4784097beb.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Prevent inlining of bpf_fentry_test7()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Mon, 28 Aug 2023 03:01:36 +0300
In-Reply-To: <20230826200843.2210074-1-yonghong.song@linux.dev>
References: <20230826200843.2210074-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 2023-08-26 at 13:08 -0700, Yonghong Song wrote:
> With latest clang18, I hit test_progs failures for the following test:
>   #13/2    bpf_cookie/multi_kprobe_link_api:FAIL
>   #13/3    bpf_cookie/multi_kprobe_attach_api:FAIL
>   #13      bpf_cookie:FAIL
>   #75      fentry_fexit:FAIL
>   #76/1    fentry_test/fentry:FAIL
>   #76      fentry_test:FAIL
>   #80/1    fexit_test/fexit:FAIL
>   #80      fexit_test:FAIL
>   #110/1   kprobe_multi_test/skel_api:FAIL
>   #110/2   kprobe_multi_test/link_api_addrs:FAIL
>   #110/3   kprobe_multi_test/link_api_syms:FAIL
>   #110/4   kprobe_multi_test/attach_api_pattern:FAIL
>   #110/5   kprobe_multi_test/attach_api_addrs:FAIL
>   #110/6   kprobe_multi_test/attach_api_syms:FAIL
>   #110     kprobe_multi_test:FAIL
>=20
> For example, for #13/2, the error messages are
>   ...
>   kprobe_multi_test_run:FAIL:kprobe_test7_result unexpected kprobe_test7_=
result: actual 0 !=3D expected 1
>   ...
>   kprobe_multi_test_run:FAIL:kretprobe_test7_result unexpected kretprobe_=
test7_result: actual 0 !=3D expected 1
>=20
> clang17 does not have this issue.
>=20
> Further investigation shows that kernel func bpf_fentry_test7(), used
> in the above tests, is inlined by the compiler although it is
> marked as noinline.
>=20
>   int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>   {
>         return (long)arg;
>   }
>=20
> It is known that for simple functions like the above (e.g. just returning
> a constant or an input argument), the clang compiler may still do inlinin=
g
> for a noinline function. Adding 'asm volatile ("")' in the beginning of t=
he
> bpf_fentry_test7() can prevent inlining.

Can confirm, this patch fixes listed flaky tests for me.
(when using LLVM main 651e644595b7 from 6 days ago).

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  net/bpf/test_run.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 57a7a64b84ed..0841f8d82419 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -543,6 +543,7 @@ struct bpf_fentry_test_t {
> =20
>  int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>  {
> +	asm volatile ("");
>  	return (long)arg;
>  }
> =20


