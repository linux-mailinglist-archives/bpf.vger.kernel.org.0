Return-Path: <bpf+bounces-19291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593758290C7
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 00:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08084287EC3
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 23:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793483E47E;
	Tue,  9 Jan 2024 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJRf6NN0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC93E473;
	Tue,  9 Jan 2024 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7ba903342c2so254411739f.3;
        Tue, 09 Jan 2024 15:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704842561; x=1705447361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPqy+82fb4SEKR56UmyLvl8CBKyqJEkW6ciRME8Jc5k=;
        b=HJRf6NN07l+nSl7oMoVB2poxhZ0oZ4mncvxIuaVNCGajDuQ2RlsZdaeUvQ+l9fWbyE
         ycyUgFH43t4SocYJjF7VN5rFHweo40qIBj3pgot/bUZrCVdnFwBirzKv2C6zdjNgwHNv
         GbV8VEPV1IhTky4z6FOahlylzp8tDoAkxJNrni01EX8bIKjDM8RhOVwGxFSQXWAUJ4pg
         ldX6QdkGKLxiOtGM7vX3wxc0yiyg++138l4nfwxkFynAzIgswwosdK/8gc9K5H1Xg7UR
         S/U8Mz5CdhrbYA09Zfz4eKPrOkvSStePfr9YOZschFm+MRm2VfraJDGUYDrzYCnKBmun
         W7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704842561; x=1705447361;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uPqy+82fb4SEKR56UmyLvl8CBKyqJEkW6ciRME8Jc5k=;
        b=WuqFUPhGuTCURI147zBM9Y/EOP4gOvw8+y37jmVV0CIEoIEM61pKhnD6yZV5AnWuXt
         by0ikQQ18FFKgvcuxbfEBvLqSkcAWWawsU+aqZhUOeBGmT0QYymazBCUTqH40eQJjEGi
         oxXoXliyeimFvT9Cb7zYvlUp5QzOMConUbT5/co2GBmKZp9UjTgAME9JiMYVF5vhWRJx
         pKTKzsYKCzuYlHSIMJjknqVW95WBhCrvoK4bGkn7xIHc8tmX14dBq62wIamLK+6Da15j
         oOI1EhKTV/nsJsDVXJjWpESiODw7UBg/CuM48qnUwYVcHp5vrEzFTkYRMmlaIm/u6hHk
         0ZXA==
X-Gm-Message-State: AOJu0YwvjSzfqd1afrdkOG6yo6yScMmsPy3XVzBNUYpWNUqcL6s570Za
	7FUDkXNzGJo0OAcQHwJlzpM=
X-Google-Smtp-Source: AGHT+IGGt6OAJV1oxXGi3mKg/cLI3CBEmG5ulIXCjnOwGBwFESR2ItT+BmBDixngwudJjuOzHAmo5A==
X-Received: by 2002:a05:6e02:b2d:b0:360:976f:d0b8 with SMTP id e13-20020a056e020b2d00b00360976fd0b8mr210234ilu.44.1704842560724;
        Tue, 09 Jan 2024 15:22:40 -0800 (PST)
Received: from localhost ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id v3-20020a1709029a0300b001d4c316e3a4sm2303718plp.189.2024.01.09.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:22:40 -0800 (PST)
Date: Tue, 09 Jan 2024 15:22:39 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>, 
 syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com
Cc: andrii@kernel.org, 
 ast@kernel.org, 
 borisp@nvidia.com, 
 bpf@vger.kernel.org, 
 daniel@iogearbox.net, 
 davem@davemloft.net, 
 dhowells@redhat.com, 
 edumazet@google.com, 
 jakub@cloudflare.com, 
 john.fastabend@gmail.com, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 syzkaller-bugs@googlegroups.com
Message-ID: <659dd53f1652b_2796120896@john.notmuch>
In-Reply-To: <tencent_146C309740E8F6ECD2CC5C7ADA6E202D450A@qq.com>
References: <000000000000aa2f41060e363b2b@google.com>
 <tencent_146C309740E8F6ECD2CC5C7ADA6E202D450A@qq.com>
Subject: RE: [PATCH] tls: fix WARNING in __sk_msg_free
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Edward Adam Davis wrote:
> Syzbot constructed 32 scatterlists, and the data members in struct sk_msg_sg 
> can only store a maximum of MAX_MSG_FRAGS scatterlists.
> However, the value of MAX_MSG_FRAGS=CONFIG_MAX_SKB_FRAG is less than 32, which
> leads to the warning reported here.
> 
> Prevent similar issues from occurring by checking whether sg.end is greater 
> than MAX_MSG_FRAGS.
> 
> Reported-and-tested-by: syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/tls/tls_sw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index e37b4d2e2acd..68dbe821f61d 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1016,6 +1016,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  
>  		msg_pl = &rec->msg_plaintext;
>  		msg_en = &rec->msg_encrypted;
> +		if (msg_pl->sg.end >= MAX_MSG_FRAGS)
> +			return -EINVAL;
>  
>  		orig_size = msg_pl->sg.size;
>  		full_record = false;
> -- 
> 2.43.0
> 

I'll test this in a bit, but I suspect this error is because even
if the msg_pl is full (the sg.end == MAX_MSG_FRAGS) the code is
missing a full_record=true set to force the loop to do the send
and abort. My opinion is we should never iterated the loop if the
msg_pl was full.

I think something like this is actually needed.

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e37b4d2e2acd..9cfa6f8d51e3 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1052,8 +1052,10 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
                        if (ret < 0)
                                goto send_end;
                        tls_ctx->pending_open_record_frags = true;
-                       if (full_record || eor || sk_msg_full(msg_pl))
+                       if (full_record || eor || sk_msg_full(msg_pl)) {
+                               full_record = true;
                                goto copied;
+                       }
                        continue;
                }

