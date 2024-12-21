Return-Path: <bpf+bounces-47516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F31589F9F04
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 08:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2BC188D554
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 07:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5921EBFFA;
	Sat, 21 Dec 2024 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="FY1rdupN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA98F154444
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765735; cv=none; b=o1x1YhIbDBt4VtDfzx8rnUP7+m7ntEPJR59oLGPpx60EigEVPcvsUXCL4VuW/8vf22oAAOJck8Xs+zTOiNo2R4gLRhMhJ7qoovVSIO22wCa6sBK2JH6uTPBkLH11c7gu2/b7vFFHOLkfnm7cyuRAzVBoKnLxqw/FyMguvNjb0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765735; c=relaxed/simple;
	bh=VdYgoyIugbj+71Cae8f7b/3XNaXG1CuIVgxK69uZCTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZ6EdSXkf75W25clwqlbEs9smderZUKGJ5olv50KO3D/dzO1rc4b+B2SKFu48B/m404j7LJCg6ZMWSqUP9kzbyFisOd6yaEKadf4M9yykpUmvkynsizFxBJ0R2xiy/K+VK+oDpO8MsqgEopUv4SxlcWKUYlj7BpFnYuDbMqS4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=FY1rdupN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4363ae65100so28296035e9.0
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 23:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734765731; x=1735370531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDfqCZrNP8M56R6K06iXL2WlA0atYz/trKoVRKTWAZM=;
        b=FY1rdupN5Wu84zkmu9gNp391xx/aitkUYeVqoYAO7QJzf+LUyb0WVQAxPdSpBjO07f
         oh1yyPc5J3jXALZnFDAkzsAKNSND+5jZTA1lkZtCFpKMWj3vdb4tNN+l7nv/XKMrY780
         33ImwfR24j0tlxfhe+XpRstb49X1L5GCPKwSIAH5fhnzj5b9j/GogEvO/I0tklyVieXk
         cxgRo7gP9hddLhkBKTiAfcbEyaS5YYnBjT2SidRZr+Xgv6KDtW3m1twRaQy37STghU5V
         MDOobpWUQOFMsGvzJ0/dY9DNQPsVVHTB6RT8nZv444LyIX8K40V++nVPbwN+szZxAkjs
         Lxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765731; x=1735370531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDfqCZrNP8M56R6K06iXL2WlA0atYz/trKoVRKTWAZM=;
        b=UqZY+WTabRaOPcPqDwpxHXHPWWUDDQ6NgJit8hYAVlQVSy6Uus7voyCeZiWA4h6iv2
         SZzWL5ih4Kcw06zvttQ3Ps0POaEs7SfuA9gTQRzD3LGQwvhuEG2/1f1CWINxwEtbJ37s
         9sNCc2Ih2WEkjm+XAC0npAhUNt5Wz+Rh+Ndmtr0pqxjMEn0477EgEyRMVFFrUrephIn0
         28Uvjybl8RVaIAp3VuMK43xM87VIGMITB8T+4m9aOY0mUrWcnW1vjBAZNeHLXV5gWlj6
         YKyoTBxyHtcEK04SWxQYOmyI335CFbjbl1xGTl/MW+dpCL/nYwu+PGHDOUMyz6Aqwj1Y
         XWAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFtOi6fT4NGd64GFcvsaWqrR1xklqsn74x4f5QTOGX+X434OgeK0sPYqYt0hl6CUzMyNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Ev1sBbWlYq49GlrDxwjJY1pw/uhmGf1QI6pf1/HDQGxhCJcG
	QastzH/x6VjTNQY/dmI4yHHhPzFqnx9Lni8PaXo9NVTA5w/+hzVlyT5Nml0T6CE=
X-Gm-Gg: ASbGnct2mT7E7teB5Pqq4HD0BfVcihL25935h3jVSQ2nXXtvcrVRsbVxBTL20DbNdnw
	gGDM5md/NduZgrN+XaskorkZfN9RcXeZv4xVdiJHHgozLaXmxyhrk4b9BBFsm9zzm6FJb4UnZsh
	AaZTsQik+xMBFZDXLYJhBX/3D9CKWajEihiV3kFoSZO6ciqZHAAJDDJMuQqbJUctbrl0sthan8V
	wnjHUJ7/oTqZa/EQUJfuUYCYESV7IKccMr7+aqkv1Xw3n5j0pW24RDLES8gjLh9RNbXr3KZ2o5S
	FyG1KySUkYyq
X-Google-Smtp-Source: AGHT+IG9GgzCc7c19ajzoMiNbxsVpjcaCnOwHoxuB+nszKyInY0ZdFm38wO5hbiuDOtZGERyjVA/Vw==
X-Received: by 2002:a05:600c:4586:b0:431:5c3d:1700 with SMTP id 5b1f17b1804b1-43668a3a3c4mr45392495e9.21.1734765731030;
        Fri, 20 Dec 2024 23:22:11 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b287sm100799385e9.29.2024.12.20.23.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 23:22:10 -0800 (PST)
Message-ID: <26e95063-4737-42f1-91e2-74aae0e71941@blackwall.org>
Date: Sat, 21 Dec 2024 09:22:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] netkit: Allow for configuring
 needed_{head,tail}room
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: pabeni@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241219173928.464437-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241219173928.464437-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 19:39, Daniel Borkmann wrote:
> Allow the user to configure needed_{head,tail}room for both netkit
> devices. The idea is similar to 163e529200af ("veth: implement
> ndo_set_rx_headroom") with the difference that the two parameters
> can be specified upon device creation. By default the current behavior
> stays as is which is needed_{head,tail}room is 0.
> 
> In case of Cilium, for example, the netkit devices are not enslaved
> into a bridge or openvswitch device (rather, BPF-based redirection
> is used out of tcx), and as such these parameters are not propagated
> into the Pod's netns via peer device.
> 
> Given Cilium can run in vxlan/geneve tunneling mode (needed_headroom)
> and/or be used in combination with WireGuard (needed_{head,tail}room),
> allow the Cilium CNI plugin to specify these two upon netkit device
> creation.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  drivers/net/netkit.c               | 66 +++++++++++++++++++-----------
>  include/uapi/linux/if_link.h       |  2 +
>  tools/include/uapi/linux/if_link.h |  2 +
>  3 files changed, 47 insertions(+), 23 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


