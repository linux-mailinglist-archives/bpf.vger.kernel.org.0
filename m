Return-Path: <bpf+bounces-8843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECD478B24C
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 15:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7CE1C2093D
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288BD12B7B;
	Mon, 28 Aug 2023 13:54:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03669125A6
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 13:54:24 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88999D3;
	Mon, 28 Aug 2023 06:54:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so2753502f8f.0;
        Mon, 28 Aug 2023 06:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693230862; x=1693835662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDmYVoW7p8nt38CD6BvN3r9xzwRS5n00QRgr4Mi9/VU=;
        b=gh19/ymTWEypbg+l+oO/hboSV74tUyLQ0AC8+z/dSbPcrdsdoAEIFf1tJGhznWzcC4
         22hoUj9kwlKuIPRkPWFiWqDC43IwjqblEsJsw7kuScda0OX/mb3/SWWdBP8x8XEBbSul
         U7/iUmCNv/1u29JCo4OrYvzVo/8AeGkcW7nkQTdKKx/dW2PNh6Dt8uOlRfdtiMFTXSnz
         EyYEcLfWXsFNLfoYuyT/Ol0dwn6HUURaQykY7kKzQAXQOu8PqbnBIK973YdW8M5Kqbs9
         ST3lt338LPkp927J5DZb2+nV08aGccoX9hay9v7r5MfefAn/+8ml1hEVVhqwdIGQE+sX
         UXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230862; x=1693835662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDmYVoW7p8nt38CD6BvN3r9xzwRS5n00QRgr4Mi9/VU=;
        b=S6vyDs6KpND5gnOz2FEopIsEWA1oEc1d0fRRYI3W3x1cqX58iQxvmK+OmmmMKyT9h2
         +kAMBxg/nxf4ikYnJ1P7yJmYoMt2bWAtMUrTj4JZN8aXmQeL1TSAO6QGgTaG0/XV5dE7
         KGTsVDzPn1rDNT7ePeUWp4gQ/qYFka+OFaaPVeT33QsfvCLKahQ75bcASDrx57FGE8+I
         Qdr4FMWEp+UNePoX2PTbg0mBPQStEA2KgDVS6hYt/fjjjL+d3sbC1jF5vTuTB5TQxt6n
         Marbib0EjoG4+T/tNOYPbkJshLqy7qYk27S3uLxpEHjqpSkBVucH1BFRi9gx7pswtD02
         cwcg==
X-Gm-Message-State: AOJu0Yz+WepC8xY4UGOFAUUJ0w5/eLCgGXspGhQXHo6ep3BTrIYj3oxM
	3PcAoF5MPEEImfiTmdnXyms=
X-Google-Smtp-Source: AGHT+IG95nW6xPk0zV6WB4OItUlDjsx3dUBybv6nT1PqBfrGNAkcz36bK6VacMecutGOK5zkit30bA==
X-Received: by 2002:adf:ce8e:0:b0:313:ef24:6fe6 with SMTP id r14-20020adfce8e000000b00313ef246fe6mr20110183wrn.1.1693230861671;
        Mon, 28 Aug 2023 06:54:21 -0700 (PDT)
Received: from krava ([83.240.61.245])
        by smtp.gmail.com with ESMTPSA id bf8-20020a0564021a4800b00529fb5fd3b9sm4478223edb.80.2023.08.28.06.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:54:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Aug 2023 15:54:18 +0200
To: Rong Tao <rtoax@foxmail.com>
Cc: olsajiri@gmail.com, alexandre.torgue@foss.st.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, chantr4@gmail.com,
	daniel@iogearbox.net, deso@posteo.net, eddyz87@gmail.com,
	haoluo@google.com, iii@linux.ibm.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, laoar.shao@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, martin.lau@linux.dev,
	mcoquelin.stm32@gmail.com, mykolal@fb.com, rongtao@cestc.cn,
	sdf@google.com, shuah@kernel.org, song@kernel.org,
	xukuohai@huawei.com, yonghong.song@linux.dev, zwisler@google.com
Subject: Re: [PATCH bpf-next v8] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
Message-ID: <ZOynCqBv/JJyZ2Kj@krava>
References: <ZOsZwQptH05Gn9yU@krava>
 <tencent_D53295A257B55119C425836EA19E2CE84B07@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D53295A257B55119C425836EA19E2CE84B07@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 08:57:21AM +0800, Rong Tao wrote:
> Hi, jirka. Thanks for your reply.
> 
> > > @@ -164,13 +165,14 @@ int main(int argc, char **argv)
> > >  	}
> > >  
> > >  	/* initialize kernel symbol translation */
> > > -	if (load_kallsyms()) {
> > > +	ksyms = load_kallsyms();
> > 
> > if we keep the load_kallsyms/ksym_search/ksym_get_addr functions as described
> > in [1] the samples/bpf would stay untouched apart from the Makefile change
> 
> Maybe we should make this modification, wouldn't it be better? After all,
> not modifying the source code of samples/bpf is not really a reason not to
> make modifications to load_kallsyms(), what do you think?

I think we want separate selftest and samples changes and I don't see
other way to do that

> 
> In addition, if we continue to keep the original ksym_search() interface,
> the following problems are very difficult to deal with:
> 
> 	Source code ksym_search [1]
> 
>     struct ksym *ksym_search(long key)
>     {
>     	int start = 0, end = sym_cnt;
>     	int result;
>     
>     	/* kallsyms not loaded. return NULL */
>     	if (sym_cnt <= 0)
>     		return NULL;
>     
>     	while (start < end) {
>     		size_t mid = start + (end - start) / 2;
>     
>     		result = key - syms[mid].addr;
>     		if (result < 0)
>     			end = mid;
>     		else if (result > 0)
>     			start = mid + 1;
>     		else
>     			return &syms[mid];                         <<<
>     	}
>     
>     	if (start >= 1 && syms[start - 1].addr < key &&
>     	    key < syms[start].addr)
>     		/* valid ksym */
>     		return &syms[start - 1];                       <<<
>     
>     	/* out of range. return _stext */
>     	return &syms[0];                                   <<<
>     }
> 
> The original ksym_search() interface directly returns the global syms 
> address, which is also dangerous for multi-threading. If we allocate new
> memory for this, it is not a perfect solution.

the assumption was that the original ksym_search touches the global
syms allocated before running tests.. then tests that actually need
fresh kallsyms data (because of bpf_testmod load/unload) would get
their own copy of kallsyms

jirka

> 
> If we rewrite
> 
> 	struct ksym *ksym_search(long key)
> 
> to
> 	struct ksym ksym_search(long key)
> 
> This also affects the source code in samples/bpf.
> 
> The same problem exists with ksym_get_addr().
> 
> Best wishes,
> Rong Tao
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/trace_helpers.c#n100
> 
> 

