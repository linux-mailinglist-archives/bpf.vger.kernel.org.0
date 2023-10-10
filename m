Return-Path: <bpf+bounces-11783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DF7BF1C6
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 06:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0A21C20C56
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 04:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5071442B;
	Tue, 10 Oct 2023 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chIHZ97G"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB813390
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 03:59:59 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7EC9E;
	Mon,  9 Oct 2023 20:59:58 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66cef33a4bdso2008796d6.1;
        Mon, 09 Oct 2023 20:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696910397; x=1697515197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnqfOj7ctOIiXf3+b8TFlrDrSvUzVt6tNz6QS/gV5O0=;
        b=chIHZ97GIeGJ4TWleWD/+1mJlcIGQ9ytJgcNiVtMS+PSF1XIXs+tiSH0zfWy2BTHwF
         0AZ7/waRKivBPQu/0UFWIqtv4kvlUiHNURjoBs7vgFpgCLHQUuDknXU5ErqQ8MwUAQkF
         IPhNQ7EauKrT/z68ImiWJ5JRuuiN7WcJ1P8sG1nH4Ymx960+J+SWDRGs4y3nXz59c02W
         yzyGG0K7zZsx5/4J2Dcco8IzrRANh9wqXIiBjNssdJMv9K58syYDshuUaRoARIK9Ml66
         qIVo8qxgYx7DUX/26iJDdHoAfe8CDipVh9E7piocMgWjkQknHbBGRDQVLqF4B7jceKJ4
         jnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696910397; x=1697515197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnqfOj7ctOIiXf3+b8TFlrDrSvUzVt6tNz6QS/gV5O0=;
        b=awwPXDjL6bvuc7ZeeDNmZDsvCU5m3uK41blZumiSdPsBQ8Qj6YZrGyL+qLMmdao3zw
         0MBDik2IqxZ1kCCa74M0GzHgyuWX+nKBLLpdnAbTODsIkHADS4eSjpvg/VxypiAP/BiS
         vEI+sRlj5vKp9mfYO/qxhjIvUGGKbTjsUVyx4qAd7WE9Leum5q5sn/dryWmXHOunDywS
         4B5tMPAoVlIN8kSWebgIDNFi25I+dajJyrCCu9vAKp0FZmOgeurAiYdZQBQlzrZopN8Y
         S9C852PWy99R8lowVaiXhZ1iDNdcVn+y6vnufcDRAWjorrkIeMg6q8ilJhnALOg+fjXC
         xbbw==
X-Gm-Message-State: AOJu0Ywq5coK7R9vzPZrRNrX7q+0tfqKppEYQHWzbwK3Lfj8cU5vpGZJ
	zWaKp3D6gZjJ1ZeiD71idVqVReiN2yQEDqgDUKE=
X-Google-Smtp-Source: AGHT+IEaewp6cBxB/spBBdHujMNcBnAeMgTW+zXky7ue6HYgv6aCekK8DeWbXv2YINrz+is7qx3UJlmPC1kA3/eD3vU=
X-Received: by 2002:ad4:4aeb:0:b0:65d:178:15a0 with SMTP id
 cp11-20020ad44aeb000000b0065d017815a0mr16870272qvb.36.1696910397695; Mon, 09
 Oct 2023 20:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007140304.4390-1-laoar.shao@gmail.com> <20231007140304.4390-3-laoar.shao@gmail.com>
 <5ne2cximagrsq7nzghbsmimrskz77drkj4ax2ktyawquvu2r77@dl4tujtwlnec>
 <CALOAHbDdWtM8+vePYm71xtX_w_6fAANTV6qAkqC-vaiLe0Gmog@mail.gmail.com> <2q4bqtfixslupka3sod5tiahalbimocahsw75auoyx5gfowpfd@e6fgqkhzz7kg>
In-Reply-To: <2q4bqtfixslupka3sod5tiahalbimocahsw75auoyx5gfowpfd@e6fgqkhzz7kg>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 10 Oct 2023 11:59:21 +0800
Message-ID: <CALOAHbD9ddtxKmPA+0n81-b=V+--xy1NDApt_90_4njiC7gt8A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/8] cgroup: Add new helpers for cgroup1 hierarchy
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, sinquersw@gmail.com, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 10:48=E2=80=AFPM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Mon, Oct 09, 2023 at 09:10:04PM +0800, Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > Hao also pointed out the use case of a 3rd partry task[1].
>
> Sigh (I must have expulsed that mail from my mind).
>
> Is the WARN_ON_ONCE(!cgrp); of any use when
> __cset_cgroup_from_root() has
>         BUG_ON(!res_cgroup);
> ?

It is useless. will drop it. Thank you for pointing it out.

--=20
Regards
Yafang

