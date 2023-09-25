Return-Path: <bpf+bounces-10802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B887AE192
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A310B281654
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D7A2511F;
	Mon, 25 Sep 2023 22:13:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A46C25114
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 22:13:02 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC21116
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 15:13:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c0dd156e5so146005057b3.3
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695679981; x=1696284781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hj+c4x1e5heMSv1Ho6FR2gxxEUO3CoPALuVd8HaS3W0=;
        b=MiDNfdx8+SfDtFOcwlaEDKkAbqhh7dHPWPxYSzsqUM8MRBOWghs7QG0XxAbmYENTI8
         iK5lJ3L9j29D2jKZTDp5lk8Xq2mLWHvIQfyVy9L2usVMulxU5DJBw6HVOXHSRj3bEqcz
         SbejBLsjLcP97qO+eeUxSH8Knvrb6Yt+Y15sLvc17k34hkAwsRjRdgEH+buP36ouyO+b
         X8meWAfLYDHwO7w8IJo5ttGbZcN//5Xt1TQb/CouQw0AadYo78VW+RXfaclsrkJPR3HH
         pujGrv/XV27vIJ+jBL29xeIJ/NcRXhFv90h+BI1p3Ysk0CLJbNdP23Le6FJZcuLQhY/F
         8Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695679981; x=1696284781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hj+c4x1e5heMSv1Ho6FR2gxxEUO3CoPALuVd8HaS3W0=;
        b=KaRw5l5RhPhR7qs1LpSRwPJus3p+RmcOjOPDv2ycZVWD6y9VM3z//khcWyE06vz190
         QNOxCLGcPW/+HHkKAKtFwriptLRclpljHWoX02jD3NUOg3lXbQ+MxnrP9UnhTFm+urop
         RYwOYE6ezGtW5VtpFVNf+puRAm8TxrRVBUxzu6RQwgRTLM8uMIbITEATqOVZJ0twKNxC
         nhS4p9a/tH+ABH3hUCqkMAissD3Xggxx9TPSqfVwxjaFBg8QB5+Ur/R+UJHdd7OWjYaq
         gd88xD00b2vA0QXj7LVz4f6g1Xon/WLdASNXJJeY73+b8H9XUs9cRZUcvMHaglEvFVLi
         5SMg==
X-Gm-Message-State: AOJu0YyfBIAslb52O419Lj5ilKLVJ43yEemS/MtrcnLVu1s1md5AvAF0
	okKCi0AJ/kvss/Vk8jXMoiYSNvOZ/w==
X-Google-Smtp-Source: AGHT+IFDbNY2T9PGT60kVoo0H9wHsXdAhlBB1UtRe1uiZ/2gZC4ZdOOJFxBpedexk1h/rD5oGEAHz2E6+Q==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:5050:0:b0:d81:7617:a397 with SMTP id
 e77-20020a255050000000b00d817617a397mr82022ybb.9.1695679980967; Mon, 25 Sep
 2023 15:13:00 -0700 (PDT)
Date: Mon, 25 Sep 2023 17:12:41 -0500
In-Reply-To: <20230921120913.566702-5-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921120913.566702-5-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925221241.2345534-1-jrife@google.com>
Subject: Re: [PATCH bpf-next v5 4/9] bpf: Implement cgroup sockaddr hooks for
 unix sockets
From: Jordan Rife <jrife@google.com>
To: daan.j.demeyer@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@meta.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> @@ -1919,6 +1936,13 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>  		goto out;
>
>  	if (msg->msg_namelen) {
> +		err = BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk,
> +							    msg->msg_name,
> +							    &msg->msg_namelen,
> +							    NULL);
> +		if (err)
> +			goto out;
> +
>  		err = unix_validate_addr(sunaddr, msg->msg_namelen);
>  		if (err)
>  			goto out;


Just an FYI, I /think/ this is going to introduce a bug similar to the one I'm
addressing in my patch here:

- https://lore.kernel.org/netdev/20230921234642.1111903-2-jrife@google.com/

With this change, callers to sock_sendmsg() in kernel space would see their
value of msg->msg_namelen change if they are using Unix sockets. While it's
unclear if there are any real systems that would be impacted, it can't hurt to
insulate callers from these kind of side-effects. I can update my my patch to
account for possible changes to msg_namelen.

Also, with this patch series is it possible for AF_INET BPF hooks (connect4,
sendmsg4, connect6, etc.) to modify the address length?

