Return-Path: <bpf+bounces-6497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C276A5B1
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 02:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C24281768
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 00:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C767D653;
	Tue,  1 Aug 2023 00:43:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B737E;
	Tue,  1 Aug 2023 00:43:49 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4261BC8;
	Mon, 31 Jul 2023 17:43:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686e0213c0bso3505184b3a.1;
        Mon, 31 Jul 2023 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690850609; x=1691455409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhtZuHVuD/5ejYMblEMyj6RnAY5Q/SWusGE7WOY4wLk=;
        b=RVDofTb81vwCNbApr9KlLqeCll9uBMlfud/WfmddUfEN0IK3PpETDcLv6Q8CrKqyGc
         vrGsvn3wQYftFQ8P0nKXwzd4g/jbOqkt02t1/eY0RzKfpUTztKsHrxEJfGaUvEBoHnza
         8oTL79e6ngOzRjUfNCcKD6awElo7WX7j9wnSP+2/XEusL/SbKzOD9YZ6R9Pc63GOWq3W
         9s8APfiP/DHZEct6jOAEcxB3S5B93mptSEUqVTSi7uPzc6ZDsZP3Fv9AJK/bqsY+UKeS
         xTw0ePYHH/dpFa9JmYBlfnqooLGD7NQpLva3ftfWSoB7LC/7+CUIcaXZ95Up8LkDp0I9
         esNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690850609; x=1691455409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhtZuHVuD/5ejYMblEMyj6RnAY5Q/SWusGE7WOY4wLk=;
        b=gPMQnYJTM6uqDJNvFBYf387bSHGMd6uwWa4wdh9a/82k9FmTCtrXuDyQQrE8vqRfzm
         d7+6odnztP2Dq3OWv7cGk/pI6nUzSwQxwSbSvO+o19y/9ppdYrCcZUT1tEqRzh9cxpcx
         tNs6k/V2Lb0RgxCfM5LEsAB9dkoEx25Cib+XlKXFzsVajFdkqctPFSdpOw/GGysoWMms
         cw4ResOJGfU9skNuOmTBV+DnnrFIuE0+SU+3Ths8kVYQDyA2TFN268b/snQuT8esgmOU
         Ul+GQAJdFn3dl0TaUoo5a0wb9FbPkIPTEOd7jdEvh+gCqI5jAYvMgzqxo4NMuCpPi8ph
         M4eQ==
X-Gm-Message-State: ABy/qLbK77jsnYNytJe/qzLunvKPzqdKZJdXs3b4D6ESfgzpKYsrl23h
	54eKsAQPe9NKjdtI/nvEY9U=
X-Google-Smtp-Source: APBJJlEDasJjNH4eP//Am3nFp4ZsQ53OoZYJ+ckrfSoVwD3WviUA3efisvHN+OOYWAmDO2aQriVD0g==
X-Received: by 2002:a05:6a20:4a06:b0:10f:f672:6e88 with SMTP id fr6-20020a056a204a0600b0010ff6726e88mr9441980pzb.4.1690850608691;
        Mon, 31 Jul 2023 17:43:28 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:6cea])
        by smtp.gmail.com with ESMTPSA id y15-20020a637d0f000000b00563b36264besm8688220pgc.85.2023.07.31.17.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 17:43:28 -0700 (PDT)
Date: Mon, 31 Jul 2023 17:43:23 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Florent Revest <revest@chromium.org>,
	Brendan Jackman <jackmanb@chromium.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC bpf-next v7 0/6] bpf: Force to MPTCP
Message-ID: <20230801004323.l2npfegkq3srzff3@MacBook-Pro-8.local>
References: <cover.1690624340.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690624340.git.geliang.tang@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 05:57:21PM +0800, Geliang Tang wrote:
> 
> The main idea is to add a hook in sys_socket() to change the protocol id
> from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.

I still think it's a hack, but its blast radius is nicely contained.
And since I cannot propose any better I'm ok with it.

Patches 1-2 can be squashed into one.
Just like patches 3-6 as a single patch for selftests.

But before proceeding I'd like an explicit ack from netdev maintainers.

