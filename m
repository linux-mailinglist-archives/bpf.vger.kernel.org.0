Return-Path: <bpf+bounces-7739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD1677BE9A
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328271C20AE0
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08CC8D2;
	Mon, 14 Aug 2023 17:03:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35031C2D9
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:03:21 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEE310C8
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:03:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d68d99100b9so2834944276.3
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692032597; x=1692637397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0H/pqj2BR1tyIRn8q8USyPsEy4h35fWTWZztRAqhrg=;
        b=jjT0Aw84/WIQOz/+nOofiWHpKTUfsadoWis7Ko46Laoefrn472TOjAqTYA05NnB/n9
         5HpzRlIDRUr4Lrt7WsQ+YcPTUinm/SA6bpwtaTfQArHk0J7wVB/ei8AYEXjY6+B2Gh1U
         fe4uLHTHgbGh6VIFjV3IZaym8O53OHgxa8MX8LiQPM/CRAhEiSOTDtsMfaXhfSv6lE62
         8BxlpSNE1+xduInyyabNgiC0IQfb2ND8Ywc4rYQkbkkvezG+msMlO+EnGEIcpviSi6Wt
         lMwk5m6QvepgZAjpJicq07BlRaJwkV/iWSFRES5F88SAQmpxpO5tQAg8d9AcFvzlhPK3
         svfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032597; x=1692637397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0H/pqj2BR1tyIRn8q8USyPsEy4h35fWTWZztRAqhrg=;
        b=SjNsl/46bbSWVkGu1U1eaXwumwniCv1RFEvJMjIZAreYWs2WhiH+PtbyaOtHxFdGcf
         1AowS3K8+QDh0or976ElyjXs1X2vY9BMY2EMBxXVCIvHy+cDiWx1HXR/IB9vdRyLhAA3
         +e/0DRP8bICZBBmhNVP3EPt1EpS2vN421oABH3IkR1Xc6Hpmn/AuCEQiofJgf6Pbd4ex
         LG+UK9RBVuoHcZo6FDM5X52XxlcD8KpiWKYKje5Np9HjdY1jF2CB4JjJJ1uTTRSqwddx
         I02vBugep4OlG+grsZ4Od/NJBGv30h9g5uswZ3/yGJR+KPskerMUb8DpvFO8A39DXjbd
         kJtA==
X-Gm-Message-State: AOJu0YxAKi2+nJ0n6l/+ccysyhIw9tx1OhgbdZNNTjz22/rIzauBOYFI
	9D+3jeJxzJyCH4QSzG8cuG8Qq+E=
X-Google-Smtp-Source: AGHT+IHNKlkPUPE8yqucICnfhZqeHusjBYrEGm9zUtRT1Rgwu33sFdAuDxRE4qWXeH1y07JBzRqEah0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:bf86:0:b0:d09:6ba9:69ec with SMTP id
 l6-20020a25bf86000000b00d096ba969ecmr157621ybk.4.1692032597140; Mon, 14 Aug
 2023 10:03:17 -0700 (PDT)
Date: Mon, 14 Aug 2023 10:03:15 -0700
In-Reply-To: <674989d5-abc1-60fb-64ea-da25d24f935e@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810214350.106301-1-martin.kelly@crowdstrike.com> <674989d5-abc1-60fb-64ea-da25d24f935e@crowdstrike.com>
Message-ID: <ZNpeU4faW3wSgDVf@google.com>
Subject: Re: [PATCH bpf-next] libbpf: set close-on-exec flag on gzopen
From: Stanislav Fomichev <sdf@google.com>
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Marco Vedovati <marco.vedovati@crowdstrike.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/10, Martin Kelly wrote:
> On 8/10/23 14:43, Martin Kelly wrote:
> > From: Marco Vedovati <marco.vedovati@crowdstrike.com>
> > 
> > Enable the close-on-exec flag when using gzopen
> > 
> > This is especially important for multithreaded programs making use of
> > libbpf, where a fork + exec could race with libbpf library calls,
> > potentially resulting in a file descriptor leaked to the new process.
> > 
> > Signed-off-by: Marco Vedovati <marco.vedovati@crowdstrike.com>
> > ---
> >   tools/lib/bpf/libbpf.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 17883f5a44b9..b14a4376a86e 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -1978,9 +1978,9 @@ static int bpf_object__read_kconfig_file(struct bpf_object *obj, void *data)
> >   		return -ENAMETOOLONG;
> >   	/* gzopen also accepts uncompressed files. */
> > -	file = gzopen(buf, "r");
> > +	file = gzopen(buf, "re");
> >   	if (!file)
> > -		file = gzopen("/proc/config.gz", "r");
> > +		file = gzopen("/proc/config.gz", "re");
> >   	if (!file) {
> >   		pr_warn("failed to open system Kconfig\n");
> 
> Sorry for double-sending the patch; the first was missing the bpf-next
> prefix and I wasn't sure if that would be an issue. Feel free to ignore this
> patch, as the other already got a reply.

Oops, I missed your resend:

https://lore.kernel.org/bpf/ZNVf6kHamI9awatB@google.com/

Next time pls at least reply to the first 'wrong' one :-)

