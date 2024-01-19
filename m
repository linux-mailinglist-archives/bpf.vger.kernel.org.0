Return-Path: <bpf+bounces-19878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A65483255C
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 09:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D1D1C20DC9
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 08:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCBCD531;
	Fri, 19 Jan 2024 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtgoPUoc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25C28E01
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651393; cv=none; b=fi+4iM3VjdO1rscuG1CB5oj4Qi3g/xTKXbYmFBlaoxDPtscLm33hrPHTrbT0YEHukX3xwbWD6UafWwCh3jy0cUcbaa85zMJSaYBAoMIlfRHDrcLWkjrGQydTjMSkZK1Qxd90ZX6DJpSAZwKSSodQhTe7ZXbub0YdOoooc2yXzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651393; c=relaxed/simple;
	bh=rlBWNmA92O7oTT0Z2xjFu14/ZaRjOdE97M2WYUyn5tM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud3EosvE+AKV/hE7JAIyfDE08sBkaDRrzvpLYinCO6d8HC+qgxb6PWy468zNgIJzzbUiYiBgG881ZqGyNUBg/TU3sU/AIjHb2NZQNMHkrnCymizriQWGDFtNFANkzeldvVhuz7BY1YSW4OW/lTQK+F3AUphpUSBjQaQDf0Z82xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtgoPUoc; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55790581457so555482a12.3
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705651390; x=1706256190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kU/N9QNqdraOzqoaFF5z2FdAdLtcF2XhDqa6sXZkYI=;
        b=YtgoPUoc7/EzkaONTosHbfMv4fTkH8nGEnhLnh9Djhl4DID27GRlH7UDNcQZtUWcjl
         uPkD9ifcCdXQ1ATEshEYB0xY8eBtsqyxdtQolJJJMQJ9IS88JgaI9Dfp7BLGcEFvtX/z
         /g9BDFhWiG8UVRLF1SS97Wf8aImAdeApSPjD+VZIHxohVlxpbct3RRrnlDSFDVskKBzh
         Pq7kwAzZbn79NGRy705rPRM4xKUVri0HICYTbouwPo7ZMrKPa+mKm4ilnNhgTZ8whs09
         KVUlHnewPeau5msudL6+avaqCLx6ZR15ucSMfESfU9R43BV7FnPCnLV9lpW9C4OwnoM9
         cz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705651390; x=1706256190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kU/N9QNqdraOzqoaFF5z2FdAdLtcF2XhDqa6sXZkYI=;
        b=OuSqwK0vL6IQrztKkI2tFnGHEXUkvB78LHxXwYqeAxjR/B9QwQjhKBdgZuvwvbZKRE
         ljCmgGpRkNGuu1PXqNMY0ajvbCKwaDbql6tu8baiVSovmjKA8cqi77MikZ0ikgRFcKkD
         ERSr37XMP43VzIJgUzXTXYVUTeF76BaDtebR9CSdl4GS68fL1heAWJxZ2nzPbQEjVTT5
         OLOXh/5/WbIgkxWO8MyobbRaPa3KFxZxxHiEoYMaYntGaNWECSx48ykV8T/n2A6fY1Eh
         Il/2ZDs2DWaiCjSKhawUOU0qbCm/HSN6gJakfb5FCUv286sjRd8Wuc+vPHn6BSrAHmk7
         soeg==
X-Gm-Message-State: AOJu0Yzczld3dbun8wLR6Ui9h0C0SAyeViVhBLoYB0Ci4zi89ylfwWgE
	xmJxGdN3I9GD7gmOM6r5H4LWwfp8girxBN4H18cPu0iKcrxjrmDS
X-Google-Smtp-Source: AGHT+IEHvzCA5CMe80PxXtGtDrmGY2WW7beZ4NDF0xZ/iFxsvBLKzyhQZ/AQdJB9LCsYlcFK8yPZuQ==
X-Received: by 2002:a50:9fca:0:b0:55a:47d6:ba25 with SMTP id c68-20020a509fca000000b0055a47d6ba25mr663276edf.33.1705651389970;
        Fri, 19 Jan 2024 00:03:09 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ev24-20020a056402541800b005581573e251sm10487303edb.2.2024.01.19.00.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:03:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Jan 2024 09:03:07 +0100
To: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH bpf-next 8/8] bpftool: Display cookie for kprobe multi
 link
Message-ID: <Zaosu7TEPONDZRog@krava>
References: <20240118095416.989152-1-jolsa@kernel.org>
 <20240118095416.989152-9-jolsa@kernel.org>
 <48e86f23-d938-4705-b91a-adbe4ee3123c@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48e86f23-d938-4705-b91a-adbe4ee3123c@isovalent.com>

On Thu, Jan 18, 2024 at 05:51:17PM +0000, Quentin Monnet wrote:

SNIP

> >  static __u64 *u64_to_arr(__u64 val)
> > @@ -675,8 +706,8 @@ void netfilter_dump_plain(const struct bpf_link_info *info)
> >  
> >  static void show_kprobe_multi_plain(struct bpf_link_info *info)
> >  {
> > +	struct addr_cookie *data;
> >  	__u32 i, j = 0;
> > -	__u64 *addrs;
> >  
> >  	if (!info->kprobe_multi.count)
> >  		return;
> > @@ -688,8 +719,11 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
> >  	printf("func_cnt %u  ", info->kprobe_multi.count);
> >  	if (info->kprobe_multi.missed)
> >  		printf("missed %llu  ", info->kprobe_multi.missed);
> > -	addrs = (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
> > -	qsort(addrs, info->kprobe_multi.count, sizeof(__u64), cmp_u64);
> > +	data = get_addr_cookie_array(u64_to_ptr(info->kprobe_multi.addrs),
> > +				     u64_to_ptr(info->kprobe_multi.cookies),
> > +				     info->kprobe_multi.count);
> > +	if (!data)
> > +		return;
> >  
> >  	/* Load it once for all. */
> >  	if (!dd.sym_count)
> > @@ -697,12 +731,12 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
> >  	if (!dd.sym_count)
> >  		return;
> 
> Don't we need to free(data) if we return here?

good catch! I guess I got distracted by show_kprobe_multi_plain being
similar to show_kprobe_multi_json, which does not check dd.sym_count
and does not return, which it should :-\ I'll include that fix as well

thanks,
jirka

> 
> >  
> > -	printf("\n\t%-16s %s", "addr", "func [module]");
> > +	printf("\n\t%-16s %-16s %s", "addr", "cookie", "func [module]");
> >  	for (i = 0; i < dd.sym_count; i++) {
> > -		if (dd.sym_mapping[i].address != addrs[j])
> > +		if (dd.sym_mapping[i].address != data[j].addr)
> >  			continue;
> > -		printf("\n\t%016lx %s",
> > -		       dd.sym_mapping[i].address, dd.sym_mapping[i].name);
> > +		printf("\n\t%016lx %-16llx %s",
> > +		       dd.sym_mapping[i].address, data[j].cookie, dd.sym_mapping[i].name);
> >  		if (dd.sym_mapping[i].module[0] != '\0')
> >  			printf(" [%s]  ", dd.sym_mapping[i].module);
> >  		else
> > @@ -711,6 +745,7 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
> >  		if (j++ == info->kprobe_multi.count)
> >  			break;
> >  	}
> > +	free(data);
> >  }
> >  
> >  static void show_uprobe_multi_plain(struct bpf_link_info *info)
> > @@ -966,6 +1001,14 @@ static int do_show_link(int fd)
> >  				return -ENOMEM;
> >  			}
> >  			info.kprobe_multi.addrs = ptr_to_u64(addrs);
> > +			cookies = calloc(count, sizeof(__u64));
> > +			if (!cookies) {
> > +				p_err("mem alloc failed");
> > +				free(addrs);
> > +				close(fd);
> > +				return -ENOMEM;
> > +			}
> > +			info.kprobe_multi.cookies = ptr_to_u64(cookies);
> >  			goto again;
> >  		}
> >  	}
> 

