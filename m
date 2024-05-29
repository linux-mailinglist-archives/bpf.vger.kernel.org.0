Return-Path: <bpf+bounces-30849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D7F8D3B96
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36871F29022
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D46181D15;
	Wed, 29 May 2024 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biw8bEiY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC9C8DE;
	Wed, 29 May 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998414; cv=none; b=nAE3OY8XTAlC9y6hUHhj1CzELXH09Xaf3SZ1ngGTvPeAB6wGGR0xrkPMDwz/DrjL5BkzxH2y0fhUyYNXfxO/RXrwQ6wKtnGmXscoUgtUAuuYUMOy8EptmSysIuCsbTXP630fRZBz00a5d7f3lD7mdmbyk8FhGJgMXYx31JNZtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998414; c=relaxed/simple;
	bh=1YrDqDCjeozpqGC+Hig4LtVmdC1ddiYzZ7fRqmZVvk8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qilFlm8HF44c4KQ3twKurQYN23s9ZdZiuhyUrJwn9qzKci/9sL/v51ShDAH6IfOsudCO6DZUanwiJ5BYK/cclAbMKDjEGobA1ad62FRPuFh0F3SOi3/itzbAnS5L3WoiYO6Uzvar6veG4LFndPD0YdmMqGyx3s7yW6oU1a/jAqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biw8bEiY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ada6a476c2so2307256d6.2;
        Wed, 29 May 2024 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716998412; x=1717603212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4K2QerpQV9MXwwRc8iWQmIO1ZXCMRqUdixm5NbWUn0=;
        b=biw8bEiYTNtYI1zmd3UQ0J0nFog37n3hjEawOOoivrGXM+5ykYYnrF1uh24b4lOb5s
         PZEg2RmU3+I054r6Z6R1Mc1dequT8trlk2m5Gv/hpar3KJ7CbsL5eY2UJFkscdIWgyy6
         lj76QLE8Y4sv4JbCF0lRwZYJ/gqNBIhmjlZd8rkZw0S2gsLnhdlMNlicXExOvvifzsGR
         53wDToKkdRVjvaodatASTzxl6WxI6pK3P6GGEeAgt25v6EFBGtE07lUxm5f9l8cs7ysC
         VLwtOI8bN3pdk07xyy19mrGSORC8JjtH29NEJa3mftIZ7MbtReZAC7E9tzbGrKhAsiuh
         iBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716998412; x=1717603212;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C4K2QerpQV9MXwwRc8iWQmIO1ZXCMRqUdixm5NbWUn0=;
        b=sE8EVTmbdLKLiMZ3MXuE1JEkgzrIBSXg0Oa9t5nbMLRqBtqETmfjVxCGkpmfGKVFa3
         DuPEGnTeOr5oKieXfaAPJdBgPIQmWI9DpJMYmvOW2rBkrgTY2LOr9QNu9AtxvHclY4nJ
         PmBWpXZlBzUyhclNDO59vqVSARJG8Z0Ncbjb0hD8pgVjgMbLzWNBpLPrDev5cmViI4HH
         YF0ig9j7mEakr4V5C+WopYN/0+drgFJAVGg+y8DX8n93KYxLUKj2s2kBb9jjESqykEX+
         V0x4zzJCKe9gURjPAQPjOD+5MCLFve8MfWW4oFj5XZpR2NZsV88OONKEvNqu4sI/jUeQ
         UUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqGBA5mWHR5jptpATBq/eRaDuctDbJWmagCSGIubwCpNCJ/+q3eEIU1WvxxqP8SABztMip1XqKtxOortrMfGxrTZNA9KICSK60+1R9RnrkR1kw5Es1wdS8eqwFxRFO7a42L+sRPCd511LJNAS9FGo/jPCKoPk/Dz6A
X-Gm-Message-State: AOJu0YydFc6/h4kLFXtnadIDaW5Gqv3tjvjMpc6G+t/I6cN9ykvIsYl9
	u2LFxFfpa62rjDakn4Ug6MvNmQOagP//IKg2Ca5jP3BpZ1wXBi6A
X-Google-Smtp-Source: AGHT+IFzEpUQnUlI4obDYYxa0z+QrEmFjwt3H70uQKkQqLvIjFiB2vDL3+3CuPrTs+bzE6KDv1w/Qg==
X-Received: by 2002:a05:6214:4a09:b0:6ab:82d6:f01c with SMTP id 6a1803df08f44-6abcd0ceedbmr202350816d6.39.1716998411358;
        Wed, 29 May 2024 09:00:11 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad67329467sm45432966d6.95.2024.05.29.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 09:00:10 -0700 (PDT)
Date: Wed, 29 May 2024 12:00:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com, 
 syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com, 
 syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
Message-ID: <6657510aa54a4_32016c29461@willemb.c.googlers.com.notmuch>
In-Reply-To: <3d04ff60-c01b-4718-ae3d-70d19ee2019a@quicinc.com>
References: <20240528224935.1020828-1-quic_abchauha@quicinc.com>
 <665734886e2a9_31b2672946e@willemb.c.googlers.com.notmuch>
 <3d04ff60-c01b-4718-ae3d-70d19ee2019a@quicinc.com>
Subject: Re: [PATCH net] net: validate SO_TXTIME clockid coming from userspace
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan (ABC) wrote:
> 
> 
> On 5/29/2024 6:58 AM, Willem de Bruijn wrote:
> > minor: double space before userspace
> > 
> > Abhishek Chauhan wrote:
> >> Currently there are no strict checks while setting SO_TXTIME
> >> from userspace. With the recent development in skb->tstamp_type
> >> clockid with unsupported clocks results in warn_on_once, which causes
> >> unnecessary aborts in some systems which enables panic on warns.
> >>
> >> Add validation in setsockopt to support only CLOCK_REALTIME,
> >> CLOCK_MONOTONIC and CLOCK_TAI to be set from userspace.
> >>
> >> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> >> Link: https://lore.kernel.org/lkml/20240509211834.3235191-1-quic_abchauha@quicinc.com/
> > 
> > These discussions can be found directly from the referenced commit?
> > If any, I'd like to the conversation we had that arrived at this
> > approach.
> > 
> Not Directly but from the patch series. 
> 1. First link is for why we introduced skb->tstamp_type 
> 2. Second link points to the series were we discussed on two approach to solve the problem 
> one being limit the skclockid to just TAI,MONO and REALTIME. 

Ah, I missed that.
Perhaps point directly to the start of that follow-up conversation?

https://lore.kernel.org/lkml/6bdba7b6-fd22-4ea5-a356-12268674def1@quicinc.com/

> 
> 
> >> Fixes: 1693c5db6ab8 ("net: Add additional bit to support clockid_t timestamp type")
> >> Reported-by: syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=d7b227731ec589e7f4f0
> >> Reported-by: syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=30a35a2e9c5067cc43fa
> >> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>
> >> ---
> >>  net/core/sock.c | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/net/core/sock.c b/net/core/sock.c
> >> index 8629f9aecf91..f8374be9d8c9 100644
> >> --- a/net/core/sock.c
> >> +++ b/net/core/sock.c
> >> @@ -1083,6 +1083,17 @@ bool sockopt_capable(int cap)
> >>  }
> >>  EXPORT_SYMBOL(sockopt_capable);
> >>  
> >> +static int sockopt_validate_clockid(int value)
> > 
> > sock_txtime.clockid has type __kernel_clockid_t.
> > 
> 
>  __kernel_clockid_t is typedef of int.  

It is now, but the stricter type definition exists for a reason.
Try to keep the strict types where possible. Besides aiding
syntactic checks, it also helps self document code.

