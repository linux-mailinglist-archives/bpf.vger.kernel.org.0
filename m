Return-Path: <bpf+bounces-2258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2572A411
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 22:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002E92819CE
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 20:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C89121CD2;
	Fri,  9 Jun 2023 20:06:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D32A408DB
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 20:06:12 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879813A85
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 13:06:10 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b28eefb49cso915991a34.0
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 13:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686341168; x=1688933168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhgUZ/b6d8SyK6wuMhy/QUdrYEmRpokDPNLka3VEsFM=;
        b=NMpC/mp9kDSPKq28g6LDQCDDNdNID/NGCD4PlXsPaupeI+dF9VZy9b2ejR281Q3k98
         rb8B22FPmmZ0RD4boaJzVR/s13NgyWQkfTqCJpoiQvLGx/u6K2eDihPxJgpaWCTPN9M4
         69YLB0faetThS7IigtDzx38Q/Cptxe1++JWyviikhxkBlY8rTQoVyr7EdInLRnwS+yoQ
         2kIvx+KBDoNXPuvn3sR39ADkFEecwxizVPVYt7ZeAqP/Vtt31UlnUdu2P/AgAsHIkhM4
         InASaCsWEX6YsVrMjZe4FIE5oVOrAfeLrdPnhopkUt4SfFhxVdvI4CaSbx4IB7fK6fJt
         npig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341168; x=1688933168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhgUZ/b6d8SyK6wuMhy/QUdrYEmRpokDPNLka3VEsFM=;
        b=ggBbRSx0ITT4ySCIh0JiWz1pohDXqhCZZ9BsbQQRaL+JM4G9ZiMgAWs9eu/R1zNvpl
         5/ggCtjHMZikT6Yp1iMryBzSIrzmdoiBby0re/TJS4Kq2HMMQlY1xeENWUZM5iWtyd7o
         z0K4Zpwcef2Y/USgRtMEGmbup9YnZYFMsUbjQUxVFCK7IgCRHPtPoA+/k1G/6mmZhAMz
         9TWJrBfgMj9c/IcTdmWBRyhSZjveIBt7rGXACrPNteTPAkEHhejyMH+t+68k/AXJnTo8
         Xkl56XxWCiUTBjFQJZ3Qk3QpQPkDWQSkScpW9mcGrW/3YAl6MIeQfgHWtB9dBiDwLg+3
         R0PQ==
X-Gm-Message-State: AC+VfDwcCa5sFBtfI45ifG9vcqkQ7mstCwVn0tJGyL7sRWUWmUBn5XQS
	QWmdNPxIWO3F6dchWqpJRyCAfly529dyj3jrYqhR
X-Google-Smtp-Source: ACHHUZ46O13fZRr5wz1JZPgAzoj3AsioK3u9YBoDpoGeFFr4WNUgRnEFS4DSXi6Tlfcrxs+oLK/wnZQXgEqZ/V9Vh+s=
X-Received: by 2002:a05:6358:9f92:b0:129:bfd3:994 with SMTP id
 fy18-20020a0563589f9200b00129bfd30994mr1938185rwb.20.1686341168398; Fri, 09
 Jun 2023 13:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 9 Jun 2023 16:05:57 -0400
Message-ID: <CAHC9VhSzC0zV31XrEz06HKp=NNbz0XPT24ja0O1sZtNM_aXqHg@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] evm: Do HMAC of multiple per LSM xattrs for new inodes
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org, 
	serge@hallyn.com, stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	casey@schaufler-ca.com, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, kpsingh@kernel.org, 
	keescook@chromium.org, nicolas.bouchinet@clip-os.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 3, 2023 at 3:16=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> One of the major goals of LSM stacking is to run multiple LSMs side by si=
de
> without interfering with each other. The ultimate decision will depend on
> individual LSM decision.
>
> Several changes need to be made to the LSM infrastructure to be able to
> support that. This patch set tackles one of them: gives to each LSM the
> ability to specify one or multiple xattrs to be set at inode creation
> time and, at the same time, gives to EVM the ability to access all those
> xattrs and calculate the HMAC on them ...

Thanks for sticking with this Roberto, I see a few
comments/suggestions on this patchset, but overall it is looking
pretty good; I'm hopeful we will be able to merge the next revision.

--=20
paul-moore.com

