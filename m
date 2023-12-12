Return-Path: <bpf+bounces-17498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D280E846
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 10:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC5DB20B34
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACC45914A;
	Tue, 12 Dec 2023 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvOL5f6y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7104BE4
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 01:54:50 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so55908005e9.2
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 01:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702374889; x=1702979689; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MyCwxs7mKKYgdCUZjypWnlghKENzPgPY+g+RvU4i8tQ=;
        b=PvOL5f6ynM71K9sROrtEQ+t44pBIEJcS/w4emRlv/yDpUW8cT8qAr2lGjq8fSMPuGc
         ZCi/Opox5JkrtRmIeeOrglSOVn9g+sCcvE0d0z+OldyRbh1nrNVdN5yY7cJQO+c2Bsok
         q4t6WX+F53uLrSaduWF87sCqmAsH9Ccr2223c8Ybqw3od3NURht01VCHi5hJ4kmhAtpb
         XhhwzxLVB3BrTpt46gDHNjZc2DsCKhlArtdZ83LmohfCKH5jYsWNhNFmm1xeoNYBbevY
         uS4LdutuxpC9+4r8NW+6V81Bpq+ZedYwtie+sWS5xmS1tu8pNVNl/RwNtFev9s10VGXo
         DkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374889; x=1702979689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MyCwxs7mKKYgdCUZjypWnlghKENzPgPY+g+RvU4i8tQ=;
        b=qStzDhzSQKHd24gtwaIAfRLc/PwjAkMQklAlW7gKN1rwHH9D1IaHmn3nYDCLcSSEvd
         rxKstr43Xvx/h3f3bX5SM1ikNBU1RlK/ZJ4fd9XAqsLKQdv+ZdFV19ROBNz4jsJP5Jwx
         Ypg7R+f+VOR8FQnKqSYHl85g799OLaqlHKaxARy/jEkslPs2Z1/SU5ZXzp7Kh5BDfGGb
         X0dsr1qbvQ8X3a3lAd+v9r2QdMHbPEe94gImP4H+jABaQ4PRLmiljnW9EulK7Km6auZy
         EgwdyVCqlKs3OmC1jPzKl+a4lTDgL4mhPp2i/NrQTHRwzGT/IPrjE4mZWoe41Yv3ONWo
         DCWw==
X-Gm-Message-State: AOJu0Yz5ktY8wwMiO8gUgInWx7A1uKseSc+ZwhFcl1pwiFJwRkORRrY1
	uTH+fULJ73Y8IOBks/+Vea8=
X-Google-Smtp-Source: AGHT+IEGDK4Pdl/1UuS94Nw7o/GBFEz9SmfNEEWttPaHfJT/hseVCxPvmUjR/KFnCeur7ZD4Qx/VfQ==
X-Received: by 2002:a05:600c:2296:b0:40b:5e1b:54ad with SMTP id 22-20020a05600c229600b0040b5e1b54admr2956223wmf.57.1702374888565;
        Tue, 12 Dec 2023 01:54:48 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c468800b0040c488e4fb5sm6085653wmo.40.2023.12.12.01.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:54:48 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 12 Dec 2023 10:54:46 +0100
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>, Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Use __GFP_NOWARN for kvcalloc when
 attaching multiple uprobes
Message-ID: <ZXgt5kLyk9BsFRBq@krava>
References: <20231211112843.4147157-1-houtao@huaweicloud.com>
 <20231211112843.4147157-2-houtao@huaweicloud.com>
 <CAADnVQKYE7ijTtcWrdsGpTNvS0r-TTXgkw8-R5U7rWTj+-kqAA@mail.gmail.com>
 <8d17436c-66ea-dea0-38e5-6edcea6c1eea@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d17436c-66ea-dea0-38e5-6edcea6c1eea@huaweicloud.com>

On Tue, Dec 12, 2023 at 11:44:34AM +0800, Hou Tao wrote:
> Hi,
> 
> On 12/12/2023 12:50 AM, Alexei Starovoitov wrote:
> > On Mon, Dec 11, 2023 at 3:27 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> An abnormally big cnt may be passed to link_create.uprobe_multi.cnt,
> >> and it will trigger the following warning in kvmalloc_node():
> >>
> >>         if (unlikely(size > INT_MAX)) {
> >>                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> >>                 return NULL;
> >>         }
> >>
> >> Fix the warning by using __GFP_NOWARN when invoking kvzalloc() in
> >> bpf_uprobe_multi_link_attach().
> >>
> >> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> >> Reported-by: xingwei lee <xrivendell7@gmail.com>
> >> Closes: https://lore.kernel.org/bpf/CABOYnLwwJY=yFAGie59LFsUsBAgHfroVqbzZ5edAXbFE3YiNVA@mail.gmail.com
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/trace/bpf_trace.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index 774cf476a892..07b9b5896d6c 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -3378,7 +3378,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >>         err = -ENOMEM;
> >>
> >>         link = kzalloc(sizeof(*link), GFP_KERNEL);
> >> -       uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
> >> +       uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL | __GFP_NOWARN);
> > __GFP_NOWARN will hide actual malloc failures.
> > Let's limit cnt instead. Both for k and u multi probes.
> 
> Do you mean there will be no warning messages when the malloc request
> can not be fulfilled, right ?  Because kvcalloc() will still return
> -ENOMEM when __GFP_NOWARN is used, so the userspace knows the malloc
> failed. And I also found out that __GFP_NOWARN only effect the
> invocation of vmalloc(), because kvmalloc_node() enable __GFP_NOWARN for
> kmalloc() by default when the passed size is greater than PAGE_SIZE.
> 
> I also though about fixing the problem by limitation, but I could not
> get good reference values for these limitations. For multiple kprobe,
> maybe the number of kallsyms can be used as an anchor (e.g, the number
> is 207617 on my local dev machine), how about using 
> __roundup_pow_of_two(207617 * 4) = 1 << 20 for multiple kprobes ? For
> multiple uprobes, maybe (1<<20) is also suitable.

I think available_filter_functions is more relevant, because kallsyms
has everything

on fedora kernel:
  # cat available_filter_functions | wc -l
  80177

anyway to be on the safe side with some other configs and possible
huge kernel modules the '1 << 20' looks good to me, also for uprobe
multi

jirka

