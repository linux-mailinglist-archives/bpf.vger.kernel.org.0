Return-Path: <bpf+bounces-9525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C4798B29
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 19:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6507A2812EF
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252DA13FF8;
	Fri,  8 Sep 2023 17:04:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE6111B;
	Fri,  8 Sep 2023 17:04:39 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F04F19B6;
	Fri,  8 Sep 2023 10:04:38 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99bf3f59905so280047266b.3;
        Fri, 08 Sep 2023 10:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694192677; x=1694797477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57ZvQzT8uSwMhJOxXEiVm+FHuG7dmlxUbz/rogmB6vU=;
        b=EPMP/TFgPalYscCqdFqGTpYOe7NGdjaEwiQqkQpEwqHEEJTLoApoRlzP2rBPpsEE54
         8KsYvllR7rLl6lh6ZhonZvJR1XrE9cuHWIx4PvrWf+ZyMwFBetAKWfY7QIm8uP2F7nWF
         zSEpXY5ltSFNtbIdZvXcrgSSMCYNikhoAYEIdUeaeWADs5OnPAUtmF8/2fu4dp/ZpZ1n
         EH+wO4/mBEJQG76WLfVonmsZtvH5+2TJ11tT82Kw2+TwbFE5IGjLo5KM8bgSpHZeuDHw
         it8xDga3RtQh7Ukv1YgOJQLr51L/jfDFELcWIs9uHTcEjMN2ZlWeE5MZ/JnVz2qidYVm
         ddVQ==
X-Gm-Message-State: AOJu0YztReAQFOdqWQiE8Up9QvBj4/PNhSinqcYaeflvyZamz9Wh2MlU
	OJZVtJnyqpUsKnBbAxvpeXE=
X-Google-Smtp-Source: AGHT+IHYKj1fQnlinPGbS3+2SiXOR/ZeR+G9D4YK1oE2vNA54ciYrJ0PCXSUFDmbsdhLUlMLyOb0Eg==
X-Received: by 2002:a17:906:292a:b0:99d:f6e9:1cf8 with SMTP id v10-20020a170906292a00b0099df6e91cf8mr2540705ejd.20.1694192676666;
        Fri, 08 Sep 2023 10:04:36 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id op5-20020a170906bce500b00992ea405a79sm1276001ejb.166.2023.09.08.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 10:04:36 -0700 (PDT)
Date: Fri, 8 Sep 2023 10:04:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: sdf@google.com, axboe@kernel.dk, asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com, martin.lau@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, io-uring@vger.kernel.org, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v4 07/10] io_uring/cmd: return -EOPNOTSUPP if net is
 disabled
Message-ID: <ZPtUIl93hBKKqhu6@gmail.com>
References: <20230904162504.1356068-1-leitao@debian.org>
 <20230904162504.1356068-8-leitao@debian.org>
 <871qfcby28.fsf@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qfcby28.fsf@suse.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 08:32:15AM -0400, Gabriel Krisman Bertazi wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > Protect io_uring_cmd_sock() to be called if CONFIG_NET is not set. If
> > network is not enabled, but io_uring is, then we want to return
> > -EOPNOTSUPP for any possible socket operation.
> >
> > This is helpful because io_uring_cmd_sock() can now call functions that
> > only exits if CONFIG_NET is enabled without having #ifdef CONFIG_NET
> > inside the function itself.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  io_uring/uring_cmd.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > index 60f843a357e0..6a91e1af7d05 100644
> > --- a/io_uring/uring_cmd.c
> > +++ b/io_uring/uring_cmd.c
> > @@ -167,6 +167,7 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> >  }
> >  EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
> >  
> > +#if defined(CONFIG_NET)
> >  int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
> >  {
> >  	struct socket *sock = cmd->file->private_data;
> > @@ -192,4 +193,11 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
> >  		return -EOPNOTSUPP;
> >  	}
> >  }
> > +#else
> > +int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +#endif
> > +
> >  EXPORT_SYMBOL_GPL(io_uring_cmd_sock);
> 
> It doesn't make much sense to export the symbol on the !CONFIG_NET case.
> Usually, you'd make it a 'static inline' in the header file (even though
> it won't be ever inlined in this case):
> 
> in include/linux/io_uring.h:
> 
> #if defined(CONFIG_NET)
> int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags);
> #else
> static inline int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
> {
> 	return -EOPNOTSUPP;
> }
> #endif
> 
> But this is a minor detail. I'd say to consider doing it if you end up doing
> another spin of the patchset.  Other than that, looks good to me.

This makes sense, and I will add the symbol export inside the
"if defined(CONFIG_NET)" block, since I need to respin this patchset to
address the sockptr_t concern.

Thanks for the good reviews!

