Return-Path: <bpf+bounces-76105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E19CA7A65
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 13:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BF1933DF44B
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F6732AAB8;
	Fri,  5 Dec 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQHC3P/2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxP2iNwu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727FA329E66
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764932163; cv=none; b=BjSV27v/a6VhG2kq4M0IQFfDwBi5J7SmJ2VrE6tFIktENLLofcgP8lsXV/XxA//pe+C2EpdhcVPIHYktmkHPGeqVkqQP98CB+9P/OeuOC251TgKjWOUXzQIH/NW2HXZ8cln2X+f11m6b+F2memLME5sY/X+yaVuF7v1IxJPjMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764932163; c=relaxed/simple;
	bh=li1n7AiJvWRG4/ZcB/yX/5YGbsKuOzGw1EsKlGT3BtQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ooIoRGQkqFjLIl1TiBSmIvK3RBJxBSW0HZifLzx1vphyhaGw/49auB4gK3T+cIn53sXGyLqf5oWPKoCq+/WG5VfUkVjQHl4RFdN0c3z92TE6hpaz3XRVfNuyqhEFtpWL2gibGxpbGogFT4f0r8yRm6Haj4fovmm1DGaXlioGIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQHC3P/2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxP2iNwu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764932153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7gSf2n5M3odk+ChxoT6AFUK+lODC5oQOZkjvhzNfhw=;
	b=NQHC3P/2OB18nWjkxyx7xwZc5zuWwqP15gzLzBp1WWSlo+KwFIA5cR/NEP06YUinF7GKtf
	JXHGNfgqsAIScBQeLG2agZVCkOoGtexzqgHqlW60J66Eic9UlWS8B0gcUeQLyhv4jYoiJe
	GglW/wZeXdBHRsNty78XAz+kHqwV/z0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-PHlio3MGOAmN_-KpQZuJKQ-1; Fri, 05 Dec 2025 05:55:52 -0500
X-MC-Unique: PHlio3MGOAmN_-KpQZuJKQ-1
X-Mimecast-MFC-AGG-ID: PHlio3MGOAmN_-KpQZuJKQ_1764932151
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b79f6dcde96so288413666b.2
        for <bpf@vger.kernel.org>; Fri, 05 Dec 2025 02:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764932151; x=1765536951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7gSf2n5M3odk+ChxoT6AFUK+lODC5oQOZkjvhzNfhw=;
        b=BxP2iNwu0/ew0K2BhcX70SFxDDH5wPX7TPNg5v0C2W6ZTMQ4ClIlhCTT/773B8EXcR
         AR56glnVDZS4UO061amT+cLJFC4h76evOMhzbohKnEC53J7lIY+pq/F7YwZVZ6E/r5ex
         86uk5eaUAqZpCy7OaGuassAr9ZJPaBYEtrEhnl35t/7FzOyq8em33FlLLDe1cpNiNrkG
         ez+/Wo9qJF/zTUuFaHNnUhGRjqMFm67QjgU25kf7p2LyjTUgGaty8+GxhNxyuIpdlr1d
         l7RkqK6aHisb55O0PlcO7bctldlE1qvG41+8oq3uxBGCQZX7/PyX5UMf7MvpY1AOHMz/
         5nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764932151; x=1765536951;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7gSf2n5M3odk+ChxoT6AFUK+lODC5oQOZkjvhzNfhw=;
        b=C+isjYrvDYvLBP1EjmGAr9PwpNcRbBSK08YaUWCowJWHdAv4/cOydc7fbIlv6U2Hki
         do3BpKnAG+jWncn6CWetTnwybdVdSYiC102+j24vGsEiYHAthcZkV/oz6/EhDT5vlsvA
         YWTT1QJwsKeY758nxDMblZ3SkpDqtD+isX01LbjwVQ1djvKF01pjgcw0ffnuG1cDKo6H
         iOm0xISZQRP+NPSQSR3FTvYBUnwScZOoMaOdcIGV7hTY6k1PyEAePqhIbxhv3KitZ4D7
         dKOo1yuY6/OeYMKStwm5iLFpIwzeGS5Wq7iXjFGK0SbuYpp8iYaxrSj1YCI+qOi3MM5X
         7zGw==
X-Forwarded-Encrypted: i=1; AJvYcCVMewJdBOgYDYDdFkcFUIfCR7RtwOFbcE7nZo9QkSFRg9gKTIe/a4F4755CQtBLJenpu7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxrHEnHFIfnXfRCTYh35wJ8QB62B6uQ269L3ViTDhKVO32q7uJ
	6oStyBfFsD53ZjRtpgkhi2rJzCKjsgP3zd2uoAELIUa7LE9hw+muozz5dCBgv+aLBNrW7FhI6yT
	pCTqKmuwIBfIFWbHcyi3lwKntVTrPPv0M5BgaC3qRBDDwcdGVwhtTvg==
X-Gm-Gg: ASbGncvFC3w6q1IA9fMAxH2QdHU9A1r5010CMuv/P4NnlL9t4rsczWgsM3Vsmb48NLr
	jhhYeNCa3IUItIug4KrjirNs6Xp6FUMpIct2ZLKuEKKr3Ld2bZ5eREFYk7ukC0sTndmCYZ9FecW
	Tcgi4Rz9mubBixqd93dgOe4r4RTOrjr42jKHkuHP6YilYNlW5l68rIInoMKyx2PKjcMzlU26LOW
	o9t3kxaFzxbjeojthAMDZJheapDo10PYxzcFlFoF3eft/OPI8hE1FMt+V0LPXqXBanJaSM2SmGf
	tzHJWUd8qG/PqA46VojOcsvJaKAPMZasgIlR2X4WqHCg09tCZFoIcsWXkVe5g7CjWXZqLAFw0DZ
	QM6viUMb0bJNylQ==
X-Received: by 2002:a17:906:7953:b0:b73:4fbb:37a2 with SMTP id a640c23a62f3a-b79dbe8c6bcmr946950266b.5.1764932150934;
        Fri, 05 Dec 2025 02:55:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0fCpVjMBXkMIqMsOLr+JuNuOZ4LtvJSBlHhcUoih/A51LWRZLURxoWIUd3WMgn58OFYGAPA==
X-Received: by 2002:a17:906:7953:b0:b73:4fbb:37a2 with SMTP id a640c23a62f3a-b79dbe8c6bcmr946946066b.5.1764932150435;
        Fri, 05 Dec 2025 02:55:50 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49a897fsm344670966b.51.2025.12.05.02.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 02:55:49 -0800 (PST)
Message-ID: <15b104e5-7e8d-4a7c-a500-5632a4f3f9a8@redhat.com>
Date: Fri, 5 Dec 2025 11:55:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [ANN] End of year break up to January 2
From: Paolo Abeni <pabeni@redhat.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org,
 "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <bpf@vger.kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 dev@openvswitch.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, devel@lists.linux-ipsec.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
References: <3a2cf402-cba2-49d1-a87e-a4d3f35107d0@redhat.com>
Content-Language: en-US
In-Reply-To: <3a2cf402-cba2-49d1-a87e-a4d3f35107d0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The EOY break poll concluded with a substantial agreement WRT the break;
the final figures are:

			Voters	Percentage
it's great		28	41%
it's fine		23	33%
I don't care		11	16%
mildly inconvenient	5	7%
unacceptable		2	3%

Given the above, and that the capacity in this period will be severely
negatively impacted - most of the maintainers will be traveling to LPC
the next week(s) - net-next will stay closed for new features until
January 2.

Fixes (for both trees) and RFCs will be processed as usual.

Thanks,

Paolo


