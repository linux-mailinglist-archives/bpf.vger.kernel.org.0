Return-Path: <bpf+bounces-9146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536677908E2
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 19:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B102F2816A6
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757B8AD22;
	Sat,  2 Sep 2023 17:28:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328873C1E;
	Sat,  2 Sep 2023 17:28:34 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF8EA4;
	Sat,  2 Sep 2023 10:28:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so246834a12.0;
        Sat, 02 Sep 2023 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693675711; x=1694280511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7IaXdsjn5RYlEEBpoyNU0z5sLpOD8WZpjwwpazlMpBw=;
        b=KLMGaxDuiBNCaeQ/0jcYOVQ+++nkre029lGe0YLlVSmUkGk/WxaXSUrhAVvodYZwyl
         aX32FjR4SuTh2j9folV5CHG7rk5JZfze0gc/My6kQhXGeoH17siFS7jh5xphsWWwkz5H
         YpyMK7azi+HcH8WpRef72W2uXOH2a4t/CgVnuwnVSEP/MYCdWT6Bzf2LPobTbY8Doijl
         hlfZiHZGyVu+vBTp4xV/rPMrMEVdidmBi8cp7+qDUHkk16n2+vkGMJZAhC8H3fwZ/c5F
         alAlVhJaS1sqnA76HkNUYvsv9Ik+CQ4glF5IctBXkO8dRPVKwvcRgJ71JKqqq/4VOKNE
         tFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693675711; x=1694280511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IaXdsjn5RYlEEBpoyNU0z5sLpOD8WZpjwwpazlMpBw=;
        b=lZe6U7r/Ra009KeaUpXyYYJVSi+PKmqufCTflXZWU8V9Z27IBTGSTtcgBODFPvIfSy
         xNLFvfg3rM0f+YJ8Dq5OJbZVK4Vqht1ySmTK7uyTwmG5XyCNFPDEWwvsB18YfPxmq14/
         gz5Mr1QZmGPT74k+r1tAHKyzCgCM0knl6H9q0LBzY+sBTGb3GaNKEJlVL96tRGbmjiwG
         9ERX6jt5goTWCtRQCIDPQPvlgpZ2aDwybRCuTa7uA98rHm3YpfgjTVK16egqu1OdsliT
         rp+W0l/RedJ0GItyeG/svwM16mc/MfQi7YAAlBH2BaKYqahozIIVuEcO5PlkQFS+nq3Q
         5DRQ==
X-Gm-Message-State: AOJu0Yyglv96nDK0EzztWz0ZYsNwwKdL4I1f0uXgj5pb6uQeHP4E3w+t
	YlorkXl5hWVqx38frNFv3LXqvXZ4CWI=
X-Google-Smtp-Source: AGHT+IGSCYAgXxnVOzQIZjYP5KzsSF5/VEt6SWa7WO48xvXSfS0cphv1h1+GSZPNfXi7oZq8s52/yQ==
X-Received: by 2002:a05:6402:2684:b0:52b:db44:79e3 with SMTP id w4-20020a056402268400b0052bdb4479e3mr10303419edd.4.1693675711237;
        Sat, 02 Sep 2023 10:28:31 -0700 (PDT)
Received: from krava ([83.240.63.222])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640206cd00b0052a1a623267sm3599085edy.62.2023.09.02.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 10:28:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 2 Sep 2023 19:28:28 +0200
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>, xukuohai@huawei.com,
	edumazet@google.com, cong.wang@bytedance.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: sockmap, fix skb refcnt race after locking
 changes
Message-ID: <ZPNwvO8ViqLD3MmX@krava>
References: <20230901202137.214666-1-john.fastabend@gmail.com>
 <ZPJVlLXB/mggaLh5@krava>
 <d8ba77cfeff26a8d52ef05d1bae43b5ceffd1b83.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ba77cfeff26a8d52ef05d1bae43b5ceffd1b83.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 02, 2023 at 12:24:01AM +0300, Eduard Zingerman wrote:

SNIP

> > >  static void sk_psock_skb_state(struct sk_psock *psock,
> > > @@ -685,9 +691,7 @@ static void sk_psock_backlog(struct work_struct *work)
> > >  		} while (len);
> > >  
> > >  		skb = skb_dequeue(&psock->ingress_skb);
> > > -		if (!ingress) {
> > > -			kfree_skb(skb);
> > > -		}
> > > +		kfree_skb(skb);
> > >  	}
> > >  end:
> > >  	mutex_unlock(&psock->work_mutex);
> > > -- 
> > > 2.33.0
> > > 
> > 
> > there's no crash wit with fix, but I noticed I occasionally get FAIL
> > 
> 
> Please note this patch:
> https://lore.kernel.org/bpf/20230901031037.3314007-1-xukuohai@huaweicloud.com/
> Which should fix the test in question.

ah right it does, thanks

Tested-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> > #212/78  sockmap_listen/sockmap Unix test_unix_redir:OK
> > ./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transport endpoint is not connected
> > vsock_unix_redir_connectible:FAIL:1501
> > ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
> > vsock_unix_redir_connectible:FAIL:1501
> > #212/79  sockmap_listen/sockmap VSOCK test_vsock_redir:FAIL
> > #212/80  sockmap_listen/sockhash IPv4 TCP test_insert_invalid:OK
> > 
> > no idea if it's related
> > 
> > jirka
> 

