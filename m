Return-Path: <bpf+bounces-46598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502E59EC5E7
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 08:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A612820E2
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 07:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6DA1C6F70;
	Wed, 11 Dec 2024 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Qgz63uUQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1481C549C
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903259; cv=none; b=HxLdudog5PCVksgFFzznDk6ChJQo96WBJT73XIopGyvzpRQIjDW14+5IEEHaCGhpNeqbtIwLnXsw3De4PZMJLS0dHGO2NC2+eqaYoCd52g17c1lkMIIdqmKxCSAbBzp4QTJhDXQYGaEm7F60+nF0DLda+X9Bdbv0ushII7i8WCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903259; c=relaxed/simple;
	bh=fHz7PloEJF39lwxIrZG6nC654/Zre5S5a967aB1NvhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwxiVUR9nw/eCQPq92yOfL3kU8avAj/UhzFPzHmSyRMBIn+AVHWCuf5sdTMdL0TkXmknQrXMSkIjuF+k4c3e0fUvBymcXsnIMq3Dl8SDo4pUg9gZkUm3zroBHitjivKYqius3++vHybA2Fq2Yxfjg0+GToszxBUY8p/CmmKETOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Qgz63uUQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa68d0b9e7bso527852166b.3
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 23:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733903256; x=1734508056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LHyNfPQ7bEUj2B/yNK4qLI/NU2e9BiBcAaBtvQFRjU=;
        b=Qgz63uUQ+FWexj6GnDX6oMmTKjiiRN9+U0F23grp7/jXXarG8sMYejakyrpa4cIhRH
         0zwH/TCBbwMpCDYQy8x40D6JpWBF3wi8PhZW+vCeJT+7tpXB1I00loAej890eJOUC0WP
         xRtKsWJJIa42mRFjF7/Vq3BzzT5rm9TmHvcv7r55iYDZa4qGJJdDHXojT52spdcXAX9M
         M/zkiOmERecbNpiP33OYFRb7YC8d3ZL1D9lUQCdiZ/bjDXi8rQYVwYfqNfk85QWe2dxS
         AlT3I5ipJDlF2t7IzTUK+Sg7YkRZFbaaaMFq/5sYW4tFa9S5KSDBZmHcDDE1K04MF0oQ
         kPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733903256; x=1734508056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LHyNfPQ7bEUj2B/yNK4qLI/NU2e9BiBcAaBtvQFRjU=;
        b=jKAZOKs1/YB5FzffN6n/o1AwnCNKZw1Cf1GBYZMQ4TVOYK1VNo7WkQkyyZsA4rEcPy
         6Mxofh0h35NQa/G43kbUAYl0FSVfl+3vW6UweTfraYQ91G8JzL7OWS5RSfSxuj/ne972
         mut556buP2REsNnKzRkFEFDi5EsZbGVD5h6xJzMtJTqy1wgKg3w/RTqi3fPrtyec3vwm
         5n+sepeNBEUsFL823uI8l/PBCD0jW+exnXafaeeMxkBqLYnXmAcKetMYZ6jkTgQr9J9N
         KV2ZdCF7xuzTjF/9g5Z+SMHtJ0+V49kXDT23fMcBTtMWI6OjA5JyfhwGECL6COBY6Vqo
         ygRA==
X-Gm-Message-State: AOJu0Yw7xVjiR+t3e9byvO19pPBfLhXTvopiERcVuUT6FVx3+Armze+W
	FD8q4f0AvPkIlOcQDb4Z3+tuZbOveD2xa57W9Ty3Qw3oMSXh764lQBIVW7+c4GU=
X-Gm-Gg: ASbGncvynZ9NjhDU01vqhpolEQiWAFPx4aCIJqTGq04m3ky4kDuub4JTEmtATAzcQ97
	qDNTXLP/CfUnG0QtyFmK6pTNr7kuF1LLFQ13a57USRfCjADk2Dkys1u8nxGVSgSCgwE29zz9MMI
	eJBW5l3PTQc0xHbJyLbahFZyauGw9CksSICBhmgrZSHzF5cVpRPdPZDOH3l8ZZ0y/sUZvS77ToS
	DelMIO8ZuivFezZuUJAKmZZYfVYC8is9FvUf1+r+UOy+4xaB0eZKVe+
X-Google-Smtp-Source: AGHT+IFfGH0YReYOhBvyFJEcHd8lXnfD0NtqwWmh1HLugQVLF+gk8SNPaprDv2+dyCrTabU8iuU8ig==
X-Received: by 2002:a17:907:9555:b0:aa6:a7cb:4b9e with SMTP id a640c23a62f3a-aa6b10d65d8mr144761166b.1.1733903256493;
        Tue, 10 Dec 2024 23:47:36 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa695c3ac07sm343118666b.66.2024.12.10.23.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 23:47:36 -0800 (PST)
Message-ID: <edd28733-d127-4d92-8d7b-bc111347cd3d@blackwall.org>
Date: Wed, 11 Dec 2024 09:47:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/5] team: Fix initial vlan_feature set in
 __team_compute_features
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, mkubecek@suse.cz, Ido Schimmel <idosch@idosch.org>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241210141245.327886-1-daniel@iogearbox.net>
 <20241210141245.327886-4-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241210141245.327886-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 16:12, Daniel Borkmann wrote:
> Similarly as with bonding, fix the calculation of vlan_features to reuse
> netdev_base_features() in order derive the set in the same way as
> ndo_fix_features before iterating through the slave devices to refine the
> feature set.
> 
> Fixes: 3625920b62c3 ("teaming: fix vlan_features computing")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/team/team_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 1df062c67640..306416fc1db0 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -991,13 +991,14 @@ static void team_port_disable(struct team *team,
>  static void __team_compute_features(struct team *team)
>  {
>  	struct team_port *port;
> -	netdev_features_t vlan_features = TEAM_VLAN_FEATURES &
> -					  NETIF_F_ALL_FOR_ALL;
> +	netdev_features_t vlan_features = TEAM_VLAN_FEATURES;
>  	netdev_features_t enc_features  = TEAM_ENC_FEATURES;
>  	unsigned short max_hard_header_len = ETH_HLEN;
>  	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
>  					IFF_XMIT_DST_RELEASE_PERM;
>  
> +	vlan_features = netdev_base_features(vlan_features);
> +
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(port, &team->port_list, list) {
>  		vlan_features = netdev_increment_features(vlan_features,

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


