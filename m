Return-Path: <bpf+bounces-1260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB551711B03
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 02:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95447281659
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 00:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540ED136A;
	Fri, 26 May 2023 00:07:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621E17E
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 00:07:06 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B27A1B6;
	Thu, 25 May 2023 17:06:33 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af2db78b38so1407251fa.3;
        Thu, 25 May 2023 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685059591; x=1687651591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=woiW5Ajm0zMRf2vXy6/dR+uwgVdveYlW7RtIiuWEMPg=;
        b=lsvKSzO8bz+bVVqt/7ilX2Flg1ZpEznsfqCxILp+bHWh9pu02v/j83gkTOWVRMEGAo
         OA25VeDTA6RnGrC1BHTfwSDbvX8kkGQHOOUqybcJdwuw1WLGSohUD6SVfXjjhvs6jKaK
         ZEdJ4xQLabfauhjjmRsp+zplQaGeqhqiUvf6LYU2chNmgRUA5Tm8sFNFVxoCeiehQh+o
         OMDvCSg7FDTtCNGtnl55vNzgaESIqM1IoTjxKxbKVRDCklUI3Y2xjhqROXXQ+qImZWGZ
         q3c+IscnbRJk2AGwsKek4s6G2EVeD8CsryowQGRlgWAvNUpS7iE/kQsc+37NUKNPXg4p
         DfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685059591; x=1687651591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woiW5Ajm0zMRf2vXy6/dR+uwgVdveYlW7RtIiuWEMPg=;
        b=OmdbIK7u8ekkmGAnoKS8zpwBc8obsVoU08Tr2bwuZWwNWl5fWNtRAaFqn+9Ks39tEP
         +uiDVAXU1etJCsEvwEDY6WcdHWMxCGtnkdOASxSxxAJOf45CKtflG5Xp9IcbreNGBGgD
         rNn+tKVhiHeDjEjPx+lCPOyNd9cqct2EKAu2ShkS/AVzbnuSBFMIjAa833jZNGgLCvAy
         vnH1q4vtJOtJ7wohfFH45e51PnaRoI8XLOaJEeJwXsnbG9lW+6yF/1UvAV6ezrJhAGox
         bo1BrziRFghnAFrMuq9r5Bu1/5CZFDt4sruGJg1q9d9gGIZ0pWx2VwL99wtnkZaKKycy
         IE3Q==
X-Gm-Message-State: AC+VfDyqgPRiAXLQKMxtzTdjqEz9nW+pifj+u31jjQBRuoiEO2w40tpe
	kd5tgCDoQ5DZft7rekmEmsgMxRfH0kSRWA==
X-Google-Smtp-Source: ACHHUZ4FmLEDANlrwQoO5XMpqceDq+pS4UgPm4lrMe9GoPFhcCmWD6IUA+KCTifqblKPZF0SOd9/0g==
X-Received: by 2002:a2e:84d0:0:b0:2a8:c82f:2996 with SMTP id q16-20020a2e84d0000000b002a8c82f2996mr70718ljh.43.1685059590564;
        Thu, 25 May 2023 17:06:30 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h17-20020a2e3a11000000b002adab10a1fdsm443602lja.117.2023.05.25.17.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 17:06:30 -0700 (PDT)
Message-ID: <36e7531791a2b9d0513e5a883acdad0930260d73.camel@gmail.com>
Subject: Re: [PATCH v3 dwarves 0/6] Support for new btf_type_tag encoding
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
 daniel@iogearbox.net,  andrii@kernel.org, yhs@fb.com, jemarch@gnu.org,
 david.faust@oracle.com,  mykolal@fb.com
Date: Fri, 26 May 2023 03:06:28 +0300
In-Reply-To: <85637acda6983eac1787abbb07ef18c618b4193b.camel@gmail.com>
References: <20230524001825.2688661-1-eddyz87@gmail.com>
	 <85637acda6983eac1787abbb07ef18c618b4193b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-05-25 at 03:13 +0300, Eduard Zingerman wrote:
[...]
> +static void test_delete()
> +{
> +	struct rb_node *next =3D rb_first(&test_tree);
> +
> +	while (next) {
> +		struct test_struct *pos =3D rb_entry(next, struct test_struct, rb_node=
);
> +		next =3D rb_next(&pos->rb_node);
> +		rb_erase(&pos->rb_node, &structures__tree);
                                        ^^^^^^^
                                        Should be &test_tree

I made a mistake in this test code.
When correct tree is passed to rb_erase() test passes w/o segfaults.
The original issue is caused by the same 'struct structures' instance
being added to an rb_tree twice, posted a separate patch with a fix to
the mailing list.

> +	}
> +}
[...]

