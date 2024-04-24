Return-Path: <bpf+bounces-27671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1DC8B0886
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A831F241EC
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB22D15A4B0;
	Wed, 24 Apr 2024 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv9I2FP4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E9159903
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959077; cv=none; b=CfN1ygKIqodSZ3wzOHcp8vuoTUdP+TvDq7D1tdK48LFyLpMO2hBNAYdqJ4LmRLHi9/ps9wY98FWnsRF7LGdMNVlfAyGQwfVsrJe5tFkLlWpsAluD2o98diNDDpAGrWrGEsHWWLwz8JDSeaUxG5Xc3KaMtjtAu5+eS01KJqElNt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959077; c=relaxed/simple;
	bh=VPPrNjQqaq/dNMC3BDXDUs24UyWWN2l8X76U+DGtUkA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRojBOC8+9M5AW7PwL501jcvGLjBhJRdIALmDkUj4TdDRBGDCdlOFsM14WtPPWSqVl6ISW0nWTwoUTAgiP3IX2JOOUbjMUvuU4cmEVTENgPQShJBtMEov6hjwelc+NdnqhVDEeu4I5yFjOawP6BP7ZCPCfZDcb+MoVTLhBvldQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv9I2FP4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso783612866b.2
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713959074; x=1714563874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m7saa9pO1fc7BVuwu9ZF5fG22QHyWRpT8p8lkk4wLs0=;
        b=Bv9I2FP4sEjfH4TZirVBU/jTj+Z4Id1LLuUoxLPYnh+Q5KAYL7sUU+FATv4z/21Gyk
         FJuWkttreH31MrxOSb2YvGXim3IlAngoDSJAbEPIHmGTuPjysimFuj1CaEpdrzo6ae/c
         EK4UdmBjT4vcJZsDZvy78z3yCswhK7mFq/iUA3zo0m0POXWo4ZdE2Ls7yvpzf7XfZSBa
         1VKuvXn2dJNFpwsPXj121PKBtQABiiVhQm5vBz/7cMtAEUxctcZkUBidhTKLri4fHHyw
         3UjkQu0smTcMS4sa+HXhXJ5sGfnKedLyi1F70Bx5vb0gosprL8DIvhSCvHttlpxxY4Qu
         IruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959074; x=1714563874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7saa9pO1fc7BVuwu9ZF5fG22QHyWRpT8p8lkk4wLs0=;
        b=U7UZ0v9j/mvqNXJ5NbRpTUp3uzmu51KZcrD+u9337UxGdaGgiOjaDoM6EQM8WXd3s7
         cyFWdDDD7KdvVEroS2NfUEufleeZgiHUXohqUucGGLEYPHjIdKmFiG7+KPqKA5GXfKgg
         ZRdHduPpBxlET+fVAWyZDoPcM9ye/eoF6tArl42knIv6BhfV+sXK5JiMhPwN+q7pavsG
         Fh8K64iWXHumi8/zr3tiKSuaPvp6ougrjV6YDCUCWMhCRSgkSJlLlRpF4z4uOqmA/UEk
         L0HDmApc7iMxGSgs+VUOtl8ENQ7iggwTI1gZSYrTshXFMkqKZBaxq/UIOru1UvYwN2AY
         e4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVty4/7V6hfQydBveoZu/2t5/gM30t4L8MSahW5yAtc5kbgfMegWm9SAFliacHop7dmVvk5QTVtJv1CBPQcMF1qVrul
X-Gm-Message-State: AOJu0Yz2Zr4P6s1hVl5+mwVuJIrf1Q+BXhLz2JXfclSzFiBkrcBBpKFM
	1gJCc12qFD+B7W4JZAZ/oJl4964wloCZ+9W3cbOzFyAZBQJDKWcg
X-Google-Smtp-Source: AGHT+IGvYvc4XCBzvClx/E2FjZDsxMLulv4yhvMc4ED35oWu7Q5GDMnzPBQYpqnyMu1JIwVeUSNjMg==
X-Received: by 2002:a17:906:fe03:b0:a58:9748:c94c with SMTP id wy3-20020a170906fe0300b00a589748c94cmr932551ejb.8.1713959074306;
        Wed, 24 Apr 2024 04:44:34 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906d19a00b00a55662919c1sm8423287ejz.172.2024.04.24.04.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:44:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Apr 2024 13:44:31 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 5/7] libbpf: Add kprobe session attach type name
 to attach_type_name
Message-ID: <Zijwn-ZWc3V9P0pr@krava>
References: <20240422121241.1307168-1-jolsa@kernel.org>
 <20240422121241.1307168-6-jolsa@kernel.org>
 <CAEf4BzaAM90Sq6uuJAO+x-mgpqxdZ-3iqYaJCi-wegkJ8YmvbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaAM90Sq6uuJAO+x-mgpqxdZ-3iqYaJCi-wegkJ8YmvbA@mail.gmail.com>

On Tue, Apr 23, 2024 at 05:27:06PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 22, 2024 at 5:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding kprobe session attach type name to attach_type_name,
> > so libbpf_bpf_attach_type_str returns proper string name for
> > BPF_TRACE_KPROBE_MULTI_SESSION attach type.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index ca605240205f..9bf6cccb3443 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -132,6 +132,7 @@ static const char * const attach_type_name[] = {
> >         [BPF_TRACE_UPROBE_MULTI]        = "trace_uprobe_multi",
> >         [BPF_NETKIT_PRIMARY]            = "netkit_primary",
> >         [BPF_NETKIT_PEER]               = "netkit_peer",
> > +       [BPF_TRACE_KPROBE_MULTI_SESSION]        = "trace_kprobe_multi_session",
> 
> we got to shorten this to just BPF_TRACE_KPROBE_SESSION :)

ook :)

jirka

> 
> 
> >  };
> >
> >  static const char * const link_type_name[] = {
> > --
> > 2.44.0
> >

