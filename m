Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9714695A
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 14:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAWNmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 08:42:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22794 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726871AbgAWNmJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 08:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579786928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4DPy+R5bPTq7tZWsMUKnzOUpzVwlGaLd1jlg2QWm2Yw=;
        b=fpC/8lyaF5Zco8iRmj2aiLJCfyEkWaScqQSctVJIInIu0USAtoGkQ8ifBMdd0byRKPJhwN
        wxwf6fK0yh4Pf133QCyyGatbwgCvH4nfsS2QQTwXtmv1McvNA5gOI/b/3JBMMgH9IrqGtb
        edfEvva2l5YRpfKLvsfAvNFFtnNlA7Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-qGvMDXwZN0Wm9dZxhEu1TQ-1; Thu, 23 Jan 2020 08:42:06 -0500
X-MC-Unique: qGvMDXwZN0Wm9dZxhEu1TQ-1
Received: by mail-lj1-f197.google.com with SMTP id b15so1090576ljp.7
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 05:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4DPy+R5bPTq7tZWsMUKnzOUpzVwlGaLd1jlg2QWm2Yw=;
        b=ZMV7Iufd9hKpgUNoPAdmg2/J6PP8NBceSz//Gb7CB83YGinX6mQp+dAW5xNXWxOGkz
         pETSvOr++bGxZbUSXPDIGvVPqItq0q1ijbmEz8T4ETRpYqJti5nqo6YmovtYRwxD8MSu
         tzhh3XOa3QXRqNF0OQxaPK1uURviMatGJfCo1mIY3+EYoTwCM+/WoCI7T/FAnrcV174B
         Qd/Pp+nDvUKq1LwUpxU1L2Nb4RrQ14Hjv+2eSJ4tY8+w87qxNTyReuWTON0JdXtWoHUu
         l2Sua6KPlnaW/GgvNzVbsJp+7uwQwp3lxfgjfsWWHNpqnxr0MTiqzilsd8HXkR6874ag
         8IiA==
X-Gm-Message-State: APjAAAV0fcnMKhHLI7wlIQRVgNxy44NXg4Ap6k3usOKGhztvWH1A/Mlj
        sgOXvd4iZ0WNDYPk1y7yHXpIp8stQvAJtdAJ9rtj7HHUDkz+04YTO0bknL+wY6hCqHX2V0vrvql
        KzR1w/yJ3d+Og
X-Received: by 2002:a19:f811:: with SMTP id a17mr4794429lff.182.1579786924712;
        Thu, 23 Jan 2020 05:42:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTmGyH6Qd2cv+F2F7Drf9s7FCX03KscxdhXqeEkXE/A8+ijDXZ9rPq2Sq7zIK+6Vbk3ftI/Q==
X-Received: by 2002:a19:f811:: with SMTP id a17mr4794418lff.182.1579786924504;
        Thu, 23 Jan 2020 05:42:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id w20sm1284895ljo.33.2020.01.23.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 05:42:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2E9961800FF; Thu, 23 Jan 2020 14:42:03 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Amol Grover <frextrite@gmail.com>
Cc:     brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] bpf: devmap: Pass lockdep expression to RCU lists
In-Reply-To: <20200123143725.036140e7@carbon>
References: <20200123120437.26506-1-frextrite@gmail.com> <20200123143725.036140e7@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 23 Jan 2020 14:42:03 +0100
Message-ID: <87a76e9tn8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Thu, 23 Jan 2020 17:34:38 +0530
> Amol Grover <frextrite@gmail.com> wrote:
>
>> head is traversed using hlist_for_each_entry_rcu outside an
>> RCU read-side critical section but under the protection
>> of dtab->index_lock.
>
> We do hold the lock in update and delete cases, but not in the lookup
> cases.  Is it then still okay to add the lockdep_is_held() annotation?

I concluded 'yes' from the comment on hlist_for_each_entry_rcu():

The lockdep condition gets passed to this:

#define __list_check_rcu(dummy, cond, extra...)				\
	({								\
	check_arg_count_one(extra);					\
	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),		\
			 "RCU-list traversed in non-reader section!");	\
	 })


so that seems fine :)

-Toke

