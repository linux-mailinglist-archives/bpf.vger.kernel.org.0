Return-Path: <bpf+bounces-3981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C0B7473A6
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 16:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A196280E75
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 14:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46809613E;
	Tue,  4 Jul 2023 14:07:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE982575
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 14:07:52 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82094C9
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 07:07:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98e011f45ffso545202366b.3
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688479669; x=1691071669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2i0iJIFAvbHlOCGUI49jMd6KOkIKueKdz7nnwzbrnR4=;
        b=JbhkCGF5UBI0UWaYMdaPTy7CfWxRM6gzQUbTdiogmsGZ2X+kw3fOnVMFxB0vxQuXZ6
         vnexLUt6fAI1AJaDmRhwpjNqNU3H6CZBWB5BCpExUxsKz/3cHgFkJlPMp4+RpE714hr2
         Tw03yMH4L5AeDj1/RDKzrMm1kTo/oPi076joc7FgQBBxmbCiYs+T+bg/qRAi8xQtlZEG
         aIFU87khZczVbN6s86E3ki2AgGF3ELwz+gWgNsBRKeUxN6Oldfp5yyeBxPRbokyJ+NE5
         6zTQRzN+LghqBCrvSvGHvo1rrQmUHttokaG/gKmmWwX8unwAdpruq7i2bCSRSgbnXgU0
         iI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688479669; x=1691071669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i0iJIFAvbHlOCGUI49jMd6KOkIKueKdz7nnwzbrnR4=;
        b=Rdv/wCEbaItR8/put38qpcyZduoaXsFnHAjM+W6wBPLuqpqOR0d6YKFZMIhA6TgrDH
         NNCRamgLwFkyVy8VlkNrM6/1znLaoSyb8/OmuJmxskcPhgAO06PZf1n6Ra/YWfJsTm5z
         v7QK5qD/BnhZMwuxw+3rwtUHjE6ZgistM/Ks7WkFvBQ0xrkmjUac2RwJlvhmcZVNZXJA
         kysOKIlENrQNvIJsHXyXNOsDRrMg2u7S6sP5ZBLVuericSKlNgMDBWqe2/qinDDQr8Zs
         zyxrjE1QKXZPzmOe6h+iCTTe2Qw60U0t/KnxYiXhJDYFDNrq5McHHLHtKnzFIHtVHm3U
         NrOw==
X-Gm-Message-State: ABy/qLY/h50AiAQ7rLdtBDSXswZ+9mhcvpb1dFv4abbJuUpSbM+FYFwW
	nKxKz/ODB4pOo8mzlaPkHN320BvydLXN1g==
X-Google-Smtp-Source: APBJJlF5OKZcHiJ7n44HLNoxPfaSD7tddrfGW1kdIO2vgWtd/GPt+ikeL7+XNp9LSZmsngtFGxIZfQ==
X-Received: by 2002:a17:906:101e:b0:992:9005:8302 with SMTP id 30-20020a170906101e00b0099290058302mr7438380ejm.77.1688479668519;
        Tue, 04 Jul 2023 07:07:48 -0700 (PDT)
Received: from krava ([193.46.31.82])
        by smtp.gmail.com with ESMTPSA id g19-20020a170906869300b00992b8d56f3asm6828775ejx.105.2023.07.04.07.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 07:07:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Jul 2023 16:07:43 +0200
To: Jackie Liu <liu.yun@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, bpf@vger.kernel.org,
	liuyun01@kylinos.cn, lkp@intel.com
Subject: Re: [PATCH v3 1/2] libbpf: kprobe.multi: cross filter using
 available_filter_functions and kallsyms
Message-ID: <ZKQnr0VZri1pWyrO@krava>
References: <20230703013618.1959621-1-liu.yun@linux.dev>
 <ZKLGSFhBNZtOdulu@krava>
 <437ed462-8950-755d-388f-e82c57bb8c44@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437ed462-8950-755d-388f-e82c57bb8c44@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 09:33:15AM +0800, Jackie Liu wrote:

SNIP

> > 
> > should you check if you found anything (infos.cnt != 0) and return early
> > if there's nothing found
> > 
> > > +
> > > +	/* sort available functions */
> > > +	qsort(infos.syms, infos.cnt, sizeof(void *), qsort_compare_function);
> > > +
> > > +	f = fopen("/proc/kallsyms", "r");
> > 
> > why not use libbpf_kallsyms_parse for kallsyms parsing? the call below
> > would be in its callback
> 
> This place cannot directly use libbpf_kallsyms_parse, because we need
> info.syms, this value cannot be passed into the parameters of
> libbpf_kallsyms_parse, 

hum, libbpf_kallsyms_parse takes 'void *ctx', so you can pass anything
you want right? 

thanks,
jirka

> and we cannot turn info.syms into a global
> variable, which is unnecessary. The easiest way is to reimplement a A
> copy of libbpf_kallsyms_parse.
> 
> Modifications to other parts will be carried along with the next
> version.
> 
> -- 
> Jackie
> 
> > 
> > > +	if (!f) {
> > > +		err = -errno;
> > > +		pr_warn("failed to open /proc/kallsyms\n");
> > > +		goto free_infos;
> > > +	}
> > > +
> > > +	while (true) {
> > > +		unsigned long long sym_addr;
> > > +
> > > +		ret = fscanf(f, "%llx %*c %499s%*[^\n]\n", &sym_addr, sym_name);
> > > +		if (ret == EOF && feof(f))
> > > +			break;
> > > +
> > > +		if (ret != 2) {
> > > +			pr_warn("failed to read kallsyms entry: %d\n", ret);
> > > +			err = -EINVAL;
> > > +			break;
> > > +		}
> > > +
> > > +		if (!glob_match(sym_name, res->pattern))
> > > +			continue;
> > 
> > hm, we don't need to call glob_match again, we just want to check
> > if the kallsyms symbol is in infos.syms
> > 
> > > +
> > > +		if (!bsearch(&sym_name, infos.syms, infos.cnt, sizeof(void *),
> > > +			     bsearch_compare_function))
> > > +			continue;
> > > +
> > > +		err = libbpf_ensure_mem((void **)&res->addrs, &res->cap,
> > > +					sizeof(unsigned long), res->cnt + 1);
> > > +		if (err)
> > > +			break;
> > > +
> > > +		res->addrs[res->cnt++] = (unsigned long) sym_addr;
> > > +	}
> > 
> > res->cnt is check outside for 0, so we should be find here
> > 
> > jirka
> > 
> > > +
> > > +cleanup:
> > > +	fclose(f);
> > > +free_infos:
> > > +	for (i = 0; i < infos.cnt; i++)
> > > +		free((char *)infos.syms[i]);
> > > +	free(infos.syms);
> > > +
> > > +	return err;
> > >   }
> > >   struct bpf_link *
> > > @@ -10594,7 +10690,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> > >   		return libbpf_err_ptr(-EINVAL);
> > >   	if (pattern) {
> > > -		err = libbpf_kallsyms_parse(resolve_kprobe_multi_cb, &res);
> > > +		err = libbpf_available_kallsyms_parse(&res);
> > >   		if (err)
> > >   			goto error;
> > >   		if (!res.cnt) {
> > > -- 
> > > 2.25.1
> > > 

