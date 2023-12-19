Return-Path: <bpf+bounces-18345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 010C0819359
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 23:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944E31F21862
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 22:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903953D3A0;
	Tue, 19 Dec 2023 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncNJ6vWg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E363D0C1;
	Tue, 19 Dec 2023 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3aa0321b5so27101305ad.2;
        Tue, 19 Dec 2023 14:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703023569; x=1703628369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpQ/R44BfxnaThyybloTKnv0rytzbAxoza/GiXNSIDA=;
        b=ncNJ6vWgX9CegEJrw/sDH/cC/sIDn8/b+1y8rqdxZYLJFJgEFD3nbcTUN4gPitUMM6
         rDv4V7YhzMzWOWo1JMa0OBxaIV+jWepOSRPZ/xFRks3VXqArOraSIPzLkJV3/D44Tqb1
         SuuY6sPeVOg0qYmByojdfYYgiFkO13E6na+96pSQ/G1aUPOhM6T2WPB07w+ogammKqMO
         MEC00qE0QLtGNYC5mBxLGhVIfHMp9S97duNb8iQ4d6hmq3zugul3aPCrHISWL4vQz+MN
         v7n8aduHqrzxk0ainxT5phbd7yU9fN3DKXo2pWsIrYNZa7rIJi2SAudfsmERwa8xG+Rf
         CsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703023569; x=1703628369;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KpQ/R44BfxnaThyybloTKnv0rytzbAxoza/GiXNSIDA=;
        b=EZVaquAW6sh0VHpIVzEUSQ6RupExoSORzXfe+fsjJELmeEdjKn+4VP6yeqHr0OFojU
         DcVTLmZov1VxEW/19JX2cAMjW0lWhSyjAi7sCaIRTrvO9M5ti7F6Tkgs49WWQks4KpX+
         btF/tjxyEw8dIThOFIAk1Jv7Ha/tCj0j5R9Tmt60tfHKFAe/wET8rKpM657jeGSae/UO
         b90dMa+0qhG5+xoDbX+yPVzqE5oA+j8EIer0/pact39cZLXHJa+BkS8zLM8zgtvG84yU
         kWqH3rq7CaRsXfFc2KEEkr1ks2DoFAJbMJ0ZC0lNZnQ/ctL+mSZ/JXrZXihcsOxNguO3
         RbKw==
X-Gm-Message-State: AOJu0YzSS3KdUFPZNc0Y8mnRLB6O6HaWhF9pw8wRi1VLjt6dO6hFlb4F
	WmAmhZr4jflkh+J1G8etCw4=
X-Google-Smtp-Source: AGHT+IEjWk57tP9AGmj5l4hY+NlculjvAxGJP8YTdR+jwFopaczXUyZ4VFRhcpqOolsT2GNpWLn+Vw==
X-Received: by 2002:a17:902:e88f:b0:1d0:6ffd:e2da with SMTP id w15-20020a170902e88f00b001d06ffde2damr23446902plg.116.1703023569011;
        Tue, 19 Dec 2023 14:06:09 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id p17-20020a170903249100b001cfbe348ca5sm21533352plw.187.2023.12.19.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 14:06:08 -0800 (PST)
Date: Tue, 19 Dec 2023 14:06:07 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 xrivendell7@gmail.com
Cc: alexander@mihalicyn.com, 
 bpf@vger.kernel.org, 
 daan.j.demeyer@gmail.com, 
 davem@davemloft.net, 
 dhowells@redhat.com, 
 edumazet@google.com, 
 john.fastabend@gmail.com, 
 kuba@kernel.org, 
 kuniyu@amazon.com, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com
Message-ID: <658213cf198a3_96d8820886@john.notmuch>
In-Reply-To: <6581fd3754b79_95e63208f@john.notmuch>
References: <CABOYnLwXyxPukiaL36NvGvSa6yW3y0rXgrU=ABOzE-1gDAc4-g@mail.gmail.com>
 <20231219155057.12716-1-kuniyu@amazon.com>
 <6581f509a56ea_90e25208c7@john.notmuch>
 <6581fd3754b79_95e63208f@john.notmuch>
Subject: Re: memory leak in unix_create1/copy_process/security_prepare_creds
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

John Fastabend wrote:
> John Fastabend wrote:
> > Kuniyuki Iwashima wrote:
> > > From: xingwei lee <xrivendell7@gmail.com>
> > > Date: Tue, 19 Dec 2023 17:12:25 +0800
> > > > Hello I found a bug in net/af_unix in the lastest upstream linux
> > > > 6.7.rc5 and comfired in lastest net/net-next/bpf/bpf-next tree.
> > > > Titled "TITLE: memory leak in unix_create1=E2=80=9D and I also up=
load the
> > > > repro.c and repro.txt.
> > > > =

> > > > If you fix this issue, please add the following tag to the commit=
:
> > > > Reported-by: xingwei Lee <xrivendell7@gmail.com>
> > > =

> > > Thanks for reporting!
> > > =

> > > It seems 8866730aed510 forgot to add sock_put().
> > > I've confirmed that the diff below silenced kmemleak but will check=

> > > more before posting a patch.
> > =

> > Did it really silence the memleak?
> =

> Yes reverting the patch fixed the issue for me.

The problem is we call proto update twice that bumps the refcnt
when adding a the same element to the map in the same slot. I'll fix
this on sockmap side so we can keep the current af_unix logic. Should
be able to push a fix tomorrow.

We probably never noticed for other socket types because its an
unusal replace to do same sock/same slot, but af_unix has this
side effect of incrementing the refcnt that doesn't exist elsewhere.

Thanks,
John=

