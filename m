Return-Path: <bpf+bounces-27224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4201F8AB0A9
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 16:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736AF1C2183A
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BF312E1C9;
	Fri, 19 Apr 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFJp25VG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A612D1FE;
	Fri, 19 Apr 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536617; cv=none; b=a2st2T9zPnrSu1gESuIF5e0ecgZ3nbZs/huZ2SUfIP8595gtYs97i9MGDhac5xwDUFybXyEEzyebekBBcmG5tjCafAPR6muqMGi7K1fKmrpkKCX5l6JCLdbG3ES4yBNq+LpGKI/yRRxo+Sr6Z6+htSEsErdG5lnc/sXCCtn0+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536617; c=relaxed/simple;
	bh=CQ8lD6tAZHvZ3FrE5cxkWG+C+DMyKIzPatDm9LApokQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYB4tY7NhwTBgMFh/MEZitQEYg5kkNXeM/+Ftm3eHJHb7JvzEEnBJNa/GPyWIBHJzch6NIKA7t0y8wXwFeEseSaDvg2ro99Z3GQnY0YGzw1OqwfasoqKiQD+P/UsM6qS3wTZTVE4eNzu/6FGYbYaInQOSveP4y7IYykTOnJUZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFJp25VG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso349688566b.1;
        Fri, 19 Apr 2024 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713536614; x=1714141414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ8lD6tAZHvZ3FrE5cxkWG+C+DMyKIzPatDm9LApokQ=;
        b=QFJp25VGL3sqoCCV6o0dXQ/md3j/tn8+TpmgEatpnSPExoZvgO83kZAYbIxVeNAkyu
         s4KD6dIsj1J3EaRRUglIlkQ78lRmYPhMEuOrup82KX3fZSTj790Lo52TVsk2KYkQ7w6Z
         qFHAGcgcL1oW0L8WC4Nc0sC/txgeNWzUovlPNNR6GhPt7mDtC0u8uF20xjxD9WU/qSMg
         PhYodXKJqDMScg/TPlwin4Y0SwQipsVorIFldby9hcsbHAM/YAAWUQs1yAKhaRVvFstA
         zHCjk0nFt7MCCTLEXLGQGoy2vUCG1bRvd7v8oE9KqllQaRBXcWxb/YBLJpTendi+e1ya
         blmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713536614; x=1714141414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQ8lD6tAZHvZ3FrE5cxkWG+C+DMyKIzPatDm9LApokQ=;
        b=M0uqsJb1Cnrk0kfipdcwvKdy4UgvqC7t7SUYCO/bS9NSAtjRp04UfTfHceikHjoihP
         HxciWsParvk622Q5/ZzDuh8o1USNZbfWENRdW5q0YpViGIpdBjTK3niQMlO5sLMnhH8Z
         aG9XsKHwN/cILhHWtXAuFQfsG/YWJYlItgk+wEF1rnBIr+SYYWvnnKWkui3Dyt4KbDtD
         gXugZm2W0WOq5RUzXWGkQVIAfTb6sFokMCSp+Y/325ek5GNXqjs5YpJvq3Wc7/fq1FQZ
         368XVfomdFDtFBa/5dlaKQ3cM9pmqZI+VglhrvRtLq8iFYjyjxz39DdHgn32Kx6DSaM3
         Mf8A==
X-Forwarded-Encrypted: i=1; AJvYcCWk6rDIR+pqQ8xUk6h567PtYOPy9ialEjzAtyIt9upoWVrBrKbp4e30mvkus8tpsgW1+cpL1mkatm76SEWjInc++rD1mdmHtZacPJJu5tMIN5zRpwpzTbLrILcG
X-Gm-Message-State: AOJu0YyljhgHI+1qAeWFjsV5kRpxNEyi2lkckzQNTJ0qqeKuwx3RNBKI
	k26bjBiz0qwqN2vudSSLs0vOQ+n91vgohzAQ8nG5c1OLS+mpOihQrZMlgWA+RG3gI8ltZoPqAW8
	CyHmpqTUtL0OKyFNGbl8Yrsklc/g=
X-Google-Smtp-Source: AGHT+IFhgOVOIwt+yovSdbBtBldH/yRf0LE/d5QB27QuDK4PEeb/B5FBjPmQ3Ps70E/wTcMYgfcWwJBKh3IYyJ2AMS0=
X-Received: by 2002:a17:906:6a11:b0:a55:7820:dfe9 with SMTP id
 qw17-20020a1709066a1100b00a557820dfe9mr4816953ejc.1.1713536613387; Fri, 19
 Apr 2024 07:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com> <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Apr 2024 07:23:21 -0700
Message-ID: <CAADnVQ+-FBTQE+Mx09PHKStb5X=d1zPt_Q8QYUioUpyKC4TA7A@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	khalidm@nvidia.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	victor@mojatatu.com, Pedro Tammela <pctammela@mojatatu.com>, Vipin.Jain@amd.com, 
	dan.daly@intel.com, andy.fingerhut@gmail.com, chris.sommers@keysight.com, 
	mattyk@nvidia.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 5:08=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> My view is this series should still be applied with the nacks since it
> sits entirely on its own silo within networking/TC (and has nothing to
> do with ebpf).

My Nack applies to the whole set. The kernel doesn't need this anti-feature
for many reasons already explained.

