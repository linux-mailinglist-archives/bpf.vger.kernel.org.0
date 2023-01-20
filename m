Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5548F674CD2
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjATFxM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjATFxI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:53:08 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C283A86B;
        Thu, 19 Jan 2023 21:52:54 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c26so3200905pfp.10;
        Thu, 19 Jan 2023 21:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSkoooTfA/6M/rXOZKmZ7fBZZmcflywync0U93Sh7XE=;
        b=U57MktgsIozhZK3BPk2hrjkIU3GZWh3rdzvYqEEFFb6lD+O7/OnHBx+VnkRClA0c92
         s13zO6O17alJKDfU2QkiQqA9F40qkys4w64NzCDB/XSI6vPMT3Mshm0xf5QBJQrX+EO5
         mrC8rXXNNRqalgomFnASmjTXLjrL/Yd9qftqKuBdGMPYTVA49116AFSaMsmj6zrSmkxn
         gkavXBsYILyRoe8h4fAsuIJ6/mxGa55V4clJyLKP0pDL7hRvn02zid9vfd9M8j1S8gDQ
         NNMEMRrmBXb6sQrTJiBf6HC7JYCe5asX0yQVTEvC2Cfo5IA1AfRDgz7DRVU4FtVLX9TD
         368w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSkoooTfA/6M/rXOZKmZ7fBZZmcflywync0U93Sh7XE=;
        b=MLSCoXayq7/Mwp5V9dzPo8hyEtbvvVQ0v4jIc281r4ZLjPFBwDhCVXpe0LKpF6C2zh
         gsbNXtlaK8xuYsh37K3ZbF1UW8v/Gm8MCHjWw5FRzuXqrp2Z2kYmQ+n/dkJLA+IttO/V
         AO54Pq/Dpj73+3sbSjrXv+/whKixqF3wb9TqcA67eVwaVYbn39U38mh7lKrpQGU2Ycqy
         E5E84/zeOGf023jL4nnNUALh7Jb4w+gjvVqwOwsWDwYhOKVOSKBTv7gYTi51+g1sQVhL
         uCPKNe97USwoNIGPHpgxcbS4mUHVnxwD0uU3W6hrgMe+yI+x9Vyv6ZiiCngDBGI0gLqq
         RADg==
X-Gm-Message-State: AFqh2kq0rCqrc9E48Ta5vs9V24IG/trlwbmhrJTVXN/p6sbZbrgp9I8O
        tSegXrztsDPK2lLxfDZLXtY=
X-Google-Smtp-Source: AMrXdXs2Np7aLKlJw3V+6IyQ4UhUBT3mdULSyNHLfMd++V5ULouLqJQdl7sfJEFLsr0e0bUMQ6iCsg==
X-Received: by 2002:a62:ea0e:0:b0:577:d10d:6eab with SMTP id t14-20020a62ea0e000000b00577d10d6eabmr15044685pfh.21.1674193970422;
        Thu, 19 Jan 2023 21:52:50 -0800 (PST)
Received: from MacBook-Pro-6.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:186c])
        by smtp.gmail.com with ESMTPSA id z13-20020aa7990d000000b0058a313f4e4esm19496156pff.149.2023.01.19.21.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:52:49 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:52:47 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 4/8] bpf: Enable cpumasks to be queried and used
 as kptrs
Message-ID: <20230120055247.obojh465e7pk2rrp@MacBook-Pro-6.local.dhcp.thefacebook.com>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-5-void@manifault.com>
 <20230120054823.bldnkx5tl3jxejm3@MacBook-Pro-6.local.dhcp.thefacebook.com>
 <Y8ort5rBVuHD6cdt@maniforge.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ort5rBVuHD6cdt@maniforge.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 11:50:47PM -0600, David Vernet wrote:
> On Thu, Jan 19, 2023 at 09:48:23PM -0800, Alexei Starovoitov wrote:
> > On Thu, Jan 19, 2023 at 05:58:29PM -0600, David Vernet wrote:
> > > silently check for and ignore these cases at runtime. When we have e.g.
> > > per-argument kfunc flags, it might be helpful to add another KF_CPU-type
> > > flag that specifies that the verifier should validate that it's a valid
> > > CPU.
> > 
> > ...
> > 
> > > +void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask)
> > > +{
> > > +	if (!cpu_valid(cpu))
> > > +		return;
> > > +
> > > +	cpumask_set_cpu(cpu, (struct cpumask *)cpumask);
> > > +}
> > 
> > ...
> > 
> > > +void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask)
> > > +{
> > > +	if (!cpu_valid(cpu))
> > > +		return;
> > 
> > I don't think we'll be able to get rid of this with KF_CPU or special suffix.
> > The argument might be a variable and not a constant at the verification time.
> > We would have to allow passing unknown vars otherwise the UX will be too restrictive,
> > so this run-time check would have to stay.
> 
> Makes sense. We'll just leave it as is then and document that passing in
> cpu >= nr_cpus is silently ignored for any kfunc taking a cpu argument.

Eventually we can clean it up with bpf_assert infra.
