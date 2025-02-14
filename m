Return-Path: <bpf+bounces-51604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E77B2A3670B
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD158171A3A
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017951C8625;
	Fri, 14 Feb 2025 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rpghtuXo"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219A1C84B2
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565646; cv=none; b=BGTaNkFxPVXlx1B/tiLc6fPzIrWR1H1491SMSZ2sKu25JvrBzOy81HrIIQqjh67KI5k0qjmznJn4fUyhMhxVM+S58JOOvvIKHZgeDuhZ/yjIcdNrYjCBQlNeIBz5tNx7ZYAbjgaV5tldLARAqEY4dw9xDRF6+vqll5bFXoBoL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565646; c=relaxed/simple;
	bh=zif5rj88NjtjvtSbbc76IWurozX9wmC9WmlYapfzTYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liaE4UeqeD7Ievyg+2Uhr5geNsm7kShdTwmZHZa5ep96R3nu+ei3GKTyIqq4/Di7qBGD+piivw2ZvotWdS86JRY46wnGXMyoIvV7qjz0ZHMmgrXdsUJKg6RV4YXCLhcu1gb9M9GiDJYF+PvabUvzDbMZD5EyfSK3FuMVeCdRz/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rpghtuXo; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <efe32620-81d6-4e13-bfd4-9349e78c98fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739565642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6gq71nGAK/ZYyfYHU8ENJje3WlLI8QuD2A4OEwH3X7c=;
	b=rpghtuXo//7trXNQnJf4WGH3Zq3nb/8SHMaM/FQG55qrNkV7/xb52MzNmALFmkzUgbc/Cq
	IDjokGL5m5T/CaJDPBk034+OTJSwIRRoVtNh0ZbsT8JpwyeHWcBJhy3XMo7JhQfLZbQjXR
	2tpWRQgC5xBQ2fBMufCaTRE87L5Quhg=
Date: Fri, 14 Feb 2025 12:40:35 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-13-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250214010038.54131-13-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/13/25 5:00 PM, Jason Xing wrote:
> +static void test_recv_errmsg_cmsg(struct msghdr *msg)
> +{
> +	struct sock_extended_err *serr = NULL;
> +	struct scm_timestamping *tss = NULL;
> +	struct cmsghdr *cm;
> +
> +	for (cm = CMSG_FIRSTHDR(msg);
> +	     cm && cm->cmsg_len;
> +	     cm = CMSG_NXTHDR(msg, cm)) {
> +		if (cm->cmsg_level == SOL_SOCKET &&
> +		    cm->cmsg_type == SCM_TIMESTAMPING) {
> +			tss = (void *)CMSG_DATA(cm);
> +		} else if ((cm->cmsg_level == SOL_IP &&
> +			    cm->cmsg_type == IP_RECVERR) ||
> +			   (cm->cmsg_level == SOL_IPV6 &&
> +			    cm->cmsg_type == IPV6_RECVERR) ||
> +			   (cm->cmsg_level == SOL_PACKET &&
> +			    cm->cmsg_type == PACKET_TX_TIMESTAMP)) {
> +			serr = (void *)CMSG_DATA(cm);
> +			ASSERT_EQ(serr->ee_origin, SO_EE_ORIGIN_TIMESTAMPING,
> +				  "cmsg type");
> +		}
> +
> +		if (serr && tss)

Regarding this check, does it need to reset both serr and tss to NULL before the 
next iteration? e.g. It can get >1 timestamps in one recvmsg(MSG_ERRQUEUE) ?

> +			test_socket_timestamp(tss, serr->ee_info,
> +					      serr->ee_data);
> +	}
> +}
> +


