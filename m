Return-Path: <bpf+bounces-32731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D3B912864
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8939B2B552
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 14:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3636B5A0FE;
	Fri, 21 Jun 2024 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="eGMyZe6n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="VU0r1RLb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="htPeiZWK"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD233F9ED
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=50.223.129.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981266; cv=fail; b=NMDweD2vlPUF3Xt7Yg012P4NSihffeG6mlmYjbFJrHbUxZRVAXpjuah3Vm5hp/qaVNtHRVQFJUKa7jAqxyUPcUCgyKuk7rk9L4tmt9S40E4FUN7dg+lmjP3o8KW4gXZZd7D8HAesdMTUwldFAYEKI+kk5I0HfuFiVew02UzVm90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981266; c=relaxed/simple;
	bh=8yF3q6f6HXGkM3/Pfk1m4+CdPCGaHyUZMESnV8wFCK4=;
	h=To:Date:Message-ID:References:In-Reply-To:MIME-Version:CC:Subject:
	 Content-Type:From; b=QWAufpn0dS/UwMfucVNm4OUdhMvvLulbdrNsWJtc/6Y+IqLLIz4gtGKbsRuGSW/gQI/z0jOsJc5AxqlNKeqMgCit/7O3HtNtFG8WotKsxLijaRozM7IWTuddBdfCGGVSSszUHl3zM47XAN7CqqPd9WdGCsQTmT807XamgC92zBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=eGMyZe6n; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=VU0r1RLb reason="signature verification failed"; dkim=fail (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=htPeiZWK reason="signature verification failed"; arc=fail smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 07D97C15106F
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1718981264; bh=8yF3q6f6HXGkM3/Pfk1m4+CdPCGaHyUZMESnV8wFCK4=;
	h=To:Date:References:In-Reply-To:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=eGMyZe6nnNd7SsfCPioH/dv9Y4c/g1gKsy1VVNFIuiC6mN1wHvfRtOFCpceIc64IG
	 RFdtW8FkLBFazMsT6eGbOCLMOuUQSAXIlPk4J22sUfIRZdDYq9y3qKuVyR/SOjWfyC
	 D1jhC2ved3mbDP75Ygsc7stWRViPptr8FqqhgW/E=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id E509DC151522
 for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1718981263; bh=tEQWB9ot0vbxVMP13tjvXX5EoW1fGxcSLq98UpChZDk=;
 h=From:To:Date:References:In-Reply-To:CC:Subject:List-Id:
 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
 List-Unsubscribe;
 b=VU0r1RLbIL9lonE3FBeJwbCP7/wI/051loPKkkvwY22KHTt3uyGlnwcl+J+KXl1LC
 gPiDd7DHXYUi4Zi7qyWY8Zs4DBZBSHONPkft/Ot0mMqBsvgRkyXp4mSsLYLwC0ScCT
 8fzkDDK94srhAx0/PSfTQT6YUfySvlw4S+IyFI4E=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 34678C14F703;
 Fri, 21 Jun 2024 07:47:41 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -12.042
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=cisco.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OgfJafR6_Qpl; Fri, 21 Jun 2024 07:47:36 -0700 (PDT)
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 947D8C14F6BF;
 Fri, 21 Jun 2024 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=13802; q=dns/txt;
 s=iport; t=1718981256; x=1720190856;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=uObQ+DsEjNrBPnkISmLkKJhC6l4lizxc2UWKHK6ck8M=;
 b=htPeiZWK5/2f6R816EFkeiG65k8MlfsAMhQvGSpRy0yOCIRWeG5Zkpky
 GI6waVTqVzPEVNIno2TZ+F6WgcRbUXzemhMBWq+O9jHbY08+Ml84HVoox
 n7UrVQXUTGEKfa7pvOAaz7K8IkBuoPm5TKh4D/T9w4Qy6U3NgZ9NOBzqM 8=;
X-CSE-ConnectionGUID: ZrX4JxBLRJuXz/PfExGK/Q==
X-CSE-MsgGUID: Ge0JLuEhRtSOFGjnZIkI9Q==
X-IPAS-Result: =?us-ascii?q?A0AEAABJkXVmmJ1dJa0+HBsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAJYEWBgEBAQsBgUAxUnoCgRxIiCEDhE5fiG4DlzqGUhSBEQNWDwEBA?=
 =?us-ascii?q?Q0BATsJBAEBhQYCiHwCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEFAQEFAQEBA?=
 =?us-ascii?q?gEHBRQBAQEBAQEBAR4ZBRAOJ4V0DYZZAQEBAQIBElYRBQsCAQgOAwECAQIBL?=
 =?us-ascii?q?jEXBggBAQQBDQUIEgiCXgGCHBQDDiMDARBHoxgBgUACiih4gTSBAYIYBYFPA?=
 =?us-ascii?q?w8v2QsNgliBSAGIMAEkgTGIZycbgUlEgVeCaD6CH0IBAQIBgSgBEgEjHoN1g?=
 =?us-ascii?q?i8EjiiDIkGBETqCJINCBw+DMYRYhAUmC2wxjB9UdyIDJjMhAhEBVRMXCz4JF?=
 =?us-ascii?q?gIWAxsUBDAPCQsmKgY5AhIMBgYGWTQJBCMDCAQDQgMgcREDBBoECwd3gXGBN?=
 =?us-ascii?q?AQTR4E3BoFMiBoMgwUCBSEpgUsngQwWgndLbIEcAoJkgWsMYYgGYoEQgT6BZ?=
 =?us-ascii?q?QFLgwNKJYN3gQMdQAMLbT01Bg4bBQSBNQWpAgQ5FIFlAYJjBCIZFwGBGAVlR?=
 =?us-ascii?q?jKSUwqDGot3o1IKhBOMD5VYF4QFgVaLKoZ7kVVkmGYginGBOoEriGqMYIUgA?=
 =?us-ascii?q?gQCBAUCDwEBBjWBHBQ6az8eDAdwFTuCMwEBMgkWMxkPji0NCYNYgmSCMMcRe?=
 =?us-ascii?q?AI5AgcBCgEBAwkBimcBAQ?=
IronPort-PHdr: A9a23:ujuXVhR9ogtSzaM9LgBWsItgbNpso3TLVj580XJvo7tKdqLm+IztI
 wmDo/5sl1TOG47c7qEMh+nXtvX4UHcbqdaasX8EeYBRTRJNl8gMngIhDcLEQU32JfLndWo7S
 exJVURu+DewNk0GUN3maQjqq2appSUXBg25MAN0IurvHYuHgtqm0eux9rXYYh5Dg3y2ZrYhZ
 BmzpB/a49EfmpAqar5k0BbLr3BUM+hX3jZuIlSe3l7ws8yx55VktS9Xvpoc
IronPort-Data: A9a23:BfbL/ayQRQFCqDr+fjh6t+cJxirEfRIJ4+MujC+fZmUNrF6WrkUPx
 zEbXTuEPP3cYDOmctp1Od/kphgH6sKAnYIwSwVvqVhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCKa/1H1b+WJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 YOaT/H3Ygf/h2YqaDtMscpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJHMsDdE66sxTO0NTx
 e5fED4gfj+gwNvjldpXSsE07igiBNPgMIVasXZ6wHSHS/0nWpvEBa7N4Le03h9p2ZsIRqmYN
 pFfMGcwBPjDS0Un1lM/BYwvmuyri1H0ciZTrxSeoq9fD237l1QojOOwb4aFEjCMbepYxmS8u
 0/GxXjCJT81Ntqt6Dmko0v504cjmgugBdpNT+fnnhJwu3WZ3mI7CRAKWx28u/bRokSmVZdUK
 0UV4DEGrKUu+gqsVNaVdxGiqXCY+x8RR9QVGfU0rQCWw4LV7hqXQG8eQVZ8hMcOrsQ6Q3kh0
 UWE2o2vDj10u7rTQnWYnluJkd+sERoPHTMgdQUgdykY08ukmI8enj3sCe82RcZZkebJMT33x
 jmLqg03iLMSkdMH2s2HEbbv3WrESn/hEFdd2+nHYl9J+D+Vc2JMWmBFwULQ4fAFJ4GDQxzf+
 nMFgMOZqusJCPlhdRBhos1TQtlFBN7cbFUwZGKD+bF6rFxBHFb4IehtDMlWfhsBDyr9UWaBj
 LXvkQ1Q/oRPG3ChcLV6ZYm8Y+xzkvGwRIy1DKCEP4AQCnSUSONh1HwzDaJ39z2y+HXAbYlhU
 XtmWZ/2VC9BWP4PIMSeF7hDuVPU+szO7TiOHc+glUvPPUu2b3+OQrBNK0qVcu089+uFpg6Tm
 +uzxOPUoyizpNbWO3GNmaZKdAhiBSFiVfje9ZcNHsbdeVUOJY3UI6KLqV/XU9Y7z/09eyah1
 izVZ3K0P3Kj3yeceFTaMis9AF4tNL4mxU8G0eUXFQ/A81AoYJ2k6+EUcJ5fQFXt3LULISJcJ
 xXdR/i9Pw==
IronPort-HdrOrdr: A9a23:bWYvk6jg99Aj1qSX9lU8TMbjBnBQX5N23DAbv31ZSRFFG/FwyP
 re/8jzhCWVtN9OYhAdcIi7Sde9qBPnmaKc4eEqTNGftXrdyRqVxeBZnMffKlLbalfDH4JmpM
 Ndmu1FeaLN5DtB/InHCWuDYqsdKbC8mcjC65a9vhJQpENRGt1dBmxCe3+m+zhNNXJ77O0CZe
 KhD6R81l2dUEVSRP6WQlMCWO/OrcDKkpXJXT4qbiRM1CC+yRmTxPrfCRa34jcyOgkj/V4lyw
 f4uj28wp/mn+Cwyxfa2WOWxY9RgsHdxtxKA9HJotQJKx334zzYJbhJavmnhnQYseuv4FElnJ
 3nuBE7Jfl+7HvXYyWcvQbt4Q/9yzwjgkWSiWNwwEGT4vARdghKTvaptrgpNicxLHBQ++2U5Z
 g7nV5xcaAnSy8o0h6NvuQgHCsa5nZc6UBS4tL7yUYvH7f3rNRq3NciFIQ/KuZZIAvqrI8gC+
 VgF8fa+bJfdk6bdWnQui11zMWrRWlbJGbMfqEugL3d79FtpgEw82IIgMgE2nsQ/pM0TJdJo+
 zCL6RzjblLCssbd7h0CusNSda+TjWle2OADEuCZVD8UK0XMXPErJD6pL0z+eGxYZQNiJ8/go
 7IXl9UvXM7P0juFcqN1ptW9Q2lehT2YR39jsVFo5RpsLz1Q7TmdSWFVVA1isOl5+4SB8XKMs
 zDTq6+w8WTWlcGNbw5qzEWAaMiW0X2ePdlz+oGZw==
X-Talos-CUID: 9a23:BdInh22Rl+snzcwHtcM1A7xfKNoVLl/N5lPqAVKIGyFRRpCFZnzXwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3Adg/Zlw1TNMT0OKuzUDZlRjiGGzUjzKn2KmQQvJU?=
 =?us-ascii?q?8p/KjGwNyPQW8jxXme9py?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
 by alln-iport-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2024 14:47:35 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
 by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id
 45LElZko027701
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 14:47:35 GMT
X-CSE-ConnectionGUID: 1kPv8KptSNiV/anRDmDQIw==
X-CSE-MsgGUID: jFxhu4GhSSyP/n9+V5Wlog==
Authentication-Results: alln-opgw-4.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com;
 spf=Pass smtp.mailfrom=evyncke@cisco.com;
 dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.08,255,1712620800"; d="scan'208,217";a="31830476"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
 by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2024 14:47:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbJBxMnApxkltCDKnfgVYDkYEyisXJjYqZDnIGWuIvbsxY2huH+IH+/Rq+nAyXUUb/Y1lwPMfVOIPcSGVsXaIV3u7iGzNdxZTwthnnKavkR/68ogF9zb0yXrobrzmawrDj3pbeeN4n2WfmUPnYX7IJLSf+brpVZCOPcLywOw1m0+bk4HM1iMTxR0IYAF5qp1OscTq0Q3Jw+ULz6nAL+gDtUNkXLw6iuaxvSJSo7f48FBkj+5hbcGmwB1Zzar3klxIETEz1Y8XFqsHYjhAx10BdV7JAiAmchsFLawGvQRSp74/Un8MgDj6mbf7ra87CL7jMrX+9n3e6YaADGQ1RHIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uObQ+DsEjNrBPnkISmLkKJhC6l4lizxc2UWKHK6ck8M=;
 b=hxHitSId/mccg9hRbBxnCMD9ovRyVczov0NrRDPDgAEIm1kYTvqDMjGmNf0Q//IajreGcVRucDQDM0qAtIOXj/O5RXBpuyIF5ry6wM43VTFCQtFlRhsCakCmjR92C8MYT1NqfNOdmeTMB3U8wOr3XKeX8AHMh51VzuC5S/HSom0Iq1FxnNpZoTCtvaH0HZhWK+u5bFSGpbrn9/Gk0/w641UOBeaZemWH+GbA2mrLP1KZz2ATYqbyccXU3vwjCGGjMLtq3MOcdGcU2IsPwWDrhfsY8bcxgEJCFw+IXA/BBSANTvxyMg6A6ZHngqY6uH6PobXpngKb7FCaPNK5oktD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from PH0PR11MB4966.namprd11.prod.outlook.com (2603:10b6:510:42::21)
 by SA2PR11MB4826.namprd11.prod.outlook.com (2603:10b6:806:11c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 14:47:32 +0000
Received: from PH0PR11MB4966.namprd11.prod.outlook.com
 ([fe80::dad6:3d43:4561:3c11]) by PH0PR11MB4966.namprd11.prod.outlook.com
 ([fe80::dad6:3d43:4561:3c11%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 14:47:32 +0000
To: Dave Thaler <dthaler1968@googlemail.com>, "gunter.van_de_velde@nokia.com"
 <gunter.van_de_velde@nokia.com>
Thread-Topic: =?Windows-1252?Q?BPF/eBPF_non-acronym_feedback_from_Gunter_Van_de_Velde_a?=
 =?Windows-1252?Q?nd_=C9ric_Vyncke?=
Thread-Index: AdrDTCZXKUDNVTXeTPW8fVu0QvWxugAnYzCg
Date: Fri, 21 Jun 2024 14:47:32 +0000
Message-ID: <PH0PR11MB4966DACDD3F5F07C0B76C022A9C92@PH0PR11MB4966.namprd11.prod.outlook.com>
References: <171811793126.62184.9537540105321678706@ietfa.amsl.com>
 <1b3301dac34c$3347df50$99d79df0$@gmail.com>
In-Reply-To: <1b3301dac34c$3347df50$99d79df0$@gmail.com>
Accept-Language: fr-BE, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4966:EE_|SA2PR11MB4826:EE_
x-ms-office365-filtering-correlation-id: 34b27f55-8b44-436e-1ab8-08dc920114f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?Windows-1252?Q?BSX9vC1bZuzfM1x80P/GjLJ/yX6sze+mrrAPlrJFzbHMikcwClHxqLmQ?=
 =?Windows-1252?Q?QEOEgRs4YfsXgYNaYV6/ZLA0OlqVtOqzmqOcUmSoilUeVQxbi6ZO1PuD?=
 =?Windows-1252?Q?i6NxIe8m/P+Fi181/6CNm+X5yhZcRboro9U0pZp3ye1VoRxSmoCEBPeK?=
 =?Windows-1252?Q?dWVeo42aXlKYUZy2oB95oHdCxIiV7QC8WQmDJ9P701ElVfnGuQTBQJLX?=
 =?Windows-1252?Q?SorXQL9stO7NMwXA2RVdU6Q0gU3yHu0P5O03ZRgEGWuKqwenFOqAqheu?=
 =?Windows-1252?Q?sfIoXxcatgHF0aAcxDMNsKYxTPeuiFdHhVwxhIJ5O5GKPULxl2edSfDY?=
 =?Windows-1252?Q?d1w7QNW7rPwgVRJPEppvdJaZe1vUvOdYLkQA1SYEn0sEZKKav5RimJPI?=
 =?Windows-1252?Q?R809r0oA/A4i/RXaju4StrwP0RVv12rMnJW3Lm7hiLnjSSgDpnKwhxdV?=
 =?Windows-1252?Q?VI1vlVgqvNVVTxMQ6CSsZ7OV2rJmmNCIHUlN5bGoMLigQ5UmCuhgPQNt?=
 =?Windows-1252?Q?R0ojgjXUU1gVewAZ2j8xEo3ZuqXOBcGf/9Jda1NgvvaALSDttqIVCiju?=
 =?Windows-1252?Q?OWXALAKNjd8JsanzXNA1qbBY/K+pyctltqtYLCQhJfG38Wsf1lvgwak8?=
 =?Windows-1252?Q?mUFhpjvTBuLZLErIcOAr+svbsmZjRxkcIJyHegOUrimpb/XBd+P46o8P?=
 =?Windows-1252?Q?kbf8lti52dHdWm8X4Z0IhZ0B6f0rKo4lIHQiyctik4q1hD9yWas+ndBb?=
 =?Windows-1252?Q?r1EiT2KG6kyGU2vFn8U+TuiWUZm2D/r9kIyTTVUgr1uOVzrIt+JARtLT?=
 =?Windows-1252?Q?pG1zgKgPcl0nFPJfNOKokqU/tNUYuZSy7yoCITwdU+z4NxAo4JWbbhln?=
 =?Windows-1252?Q?gf6RZ+9tBpi9JUQyn98BD5pHu4RNwbVVP6PdFWjApFxG2xEB8I4HrZXQ?=
 =?Windows-1252?Q?n3JLHsjclIDRtvYV/PVQk3gQorL6J/KFkT79YBpEXBxOHW/ZvoCJ4K/q?=
 =?Windows-1252?Q?9lDqoZpVjJKavlR3iOHtE9b33hwjP/qwquG4loiKgD3xwKX6wnMoDUjs?=
 =?Windows-1252?Q?e05ki/1wsDoBHS5f4Y9856KDizA60wCMBH27Wv1VZ6VhYqyKGVlx0nSq?=
 =?Windows-1252?Q?MPrWpZJdBHrkFTsNqCnbUTuQ0yVkbtXVWakgaGx+zA6Dp6nXt9gxXf1S?=
 =?Windows-1252?Q?Ye9e4C1onnRCK3+g4nBuox3cAosLjTfjbiI3NOmqbIQN4bq2ka+BWQtl?=
 =?Windows-1252?Q?aFxVwuUEcD3ktSO0sTsOAy5k5rZHRSQkThS0yttYykBevfmgdFXeC9fI?=
 =?Windows-1252?Q?NX3tJsulcCq+e8XJe4w3Wub9xAmgOyFhacHk+5eVM4CsDuXsk1XVvajZ?=
 =?Windows-1252?Q?arSClE8eUj/ZMTHSqosMLR+CHKGBoO+a+R+95dLfJadPVdv1gi3ozSi3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4966.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?/tCN/f7dPeaZ0dPWrjNoIF17tj+mp7H5OdtUtQTzcW1/YIBAE0ywnedi?=
 =?Windows-1252?Q?CsCxMHjH2MBPPJVuYDtu66W5je/7CTDp3ggDQu3Dar2dQh4J7Md3ITnq?=
 =?Windows-1252?Q?6NuTw7zHhYVJnlykIGa5DBsPigdTyQowCzpFhtIRz7Lna/hFslP4h/AI?=
 =?Windows-1252?Q?IqHCdTVgkM9rXBNhlvtCuNfnjlS/a7Og+cbvfJ1JS53L1/Q5OWD9zfVu?=
 =?Windows-1252?Q?TEB98BzuLyrM9GM2cXleeX90muRrMLdIlkUdYdcNDSJr1NRbPu6kOWQS?=
 =?Windows-1252?Q?j0nuKiicKyQ/7brDl3enKdXM+J/niHYH7jQ53wIWC70aINlnitckdVNL?=
 =?Windows-1252?Q?jbHEyK5KGFh0BxuRf+2ZnnBJSLJmhEOdh83ju6MnTeOEo7RCCsA22Y+I?=
 =?Windows-1252?Q?mYb/D5QDAGBgu9I/oMHwgNxkOLB1rSeuDCCiugA+KbT2iHM21qdxfdSD?=
 =?Windows-1252?Q?wObVX3J40s8tCIsQL0spWHa6ZTLLFNN2FP2+nkmKmgrgyrbfU0AR+tpz?=
 =?Windows-1252?Q?Y2bU9lY3/ot8edCdQ3wWgD/m5NsC2yR1nZFCwDrT7sm0HINgRzDYwuQG?=
 =?Windows-1252?Q?QiS4xcn09+HD2sHPiQ117zgRADgJM08+WD/otfwIFKiX9oSaqHqgORkG?=
 =?Windows-1252?Q?KBxXjNzJteluROyx8nmHO9IOUERgej5hejnfDrABkqJr5mJAmP87WwsG?=
 =?Windows-1252?Q?GqVxpeXiD5txf9Lv+OVXFZuMQt+gbGHGgZ/FZB2Wx2EDjnlWzMMAQWXG?=
 =?Windows-1252?Q?QQ6Xt8jAay7IynsoQ9jtBL8lSLQbGfi380OWwZkphZK1C9YyBSFZAnkj?=
 =?Windows-1252?Q?MjG223/WSDPTRXyRcTRCuP6i8PuY0u86HAHTrFlD9WXgjEchQCeD7XmG?=
 =?Windows-1252?Q?G87g8h4TGoU6rzr9+WZWQPRJZcIAhNylZBQVX+4NNvVf2+iuhPdTrFVC?=
 =?Windows-1252?Q?xlILpdEcYHOGjH4CIhazCWKROfhPQgGOUfvJuHlDVG+Acp0UPjoO3k0W?=
 =?Windows-1252?Q?gPqfBDuKUHpiZ/mD6abXX5sAETBohkfTr54OjqkE7niID7+N7lEev9St?=
 =?Windows-1252?Q?OlhEW9gEG6qw3NVqD9rE270SPOXSHAEgzldg3dlt+b6/zzyWcp4DQRUJ?=
 =?Windows-1252?Q?rMd/GpNFYSCQfBzukdleGyuUfd4i0i4GCp6tLvl28SITSGt32ZIzhv4M?=
 =?Windows-1252?Q?flOB4AkEeLT1qsg9v0ehGVsqDiLoxgzfXfIiX+wSGAPFtXhhSn+ZCF61?=
 =?Windows-1252?Q?sGuj5pqlcBu0qpK6C2GH2MzyEZNMLXxgD9V72qnv/GVZcE4Mpnse2dKc?=
 =?Windows-1252?Q?jdvB2HxAPcVlrz8Uoy07kfcTLhaFC87MYZ6aO8TNqooadBVoeoiq2CAN?=
 =?Windows-1252?Q?81n/l27RKvxnmQCy/CZLAHk0ykcuKS8EJQC6f8eYg8T5JA8gFaBJACnY?=
 =?Windows-1252?Q?VlnUGG6cqvkeCNEblcZ/Szh/cbZOMKupM2qdW1O4cAD2TwEeNhiu3X0Q?=
 =?Windows-1252?Q?RdJfF4tQt1IhlRnlhbg2VlL5oqefK/6ET3nSlvR353R8AEGLzedVkIAs?=
 =?Windows-1252?Q?Ar8VfAIxTo3/4MMAs2xvskqSjUIO1kUb0HzZnb30UhrKsvcq8jkDqyGE?=
 =?Windows-1252?Q?U4VzdSDXq/kHg8oEF2m9rBwiXVfFzsbwe+hiKZe2mA+RElAwZUC9yHDC?=
 =?Windows-1252?Q?8AzDzYifVFsKQCKQLoF4E9U3lh8k9DeJYxnZYaaJbAUIQOViPIfg3dyW?=
 =?Windows-1252?Q?6jZPodqbKr1w0x104SeeHQNewC10NTqZq9OphePJlG6Hx9WDgfDYhHo+?=
 =?Windows-1252?Q?ccp/GQ=3D=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b27f55-8b44-436e-1ab8-08dc920114f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 14:47:32.3526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/pVyDGscQmbKh01ivsxbE9Sw/6xr2k16kunCsZFBM5iaijenq1OVNRwGHteyQsDtHJ83Y+qmpYaQV/+950xhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4826
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com
Message-ID-Hash: 5M5VXLFGODS7JIH4E4CPOYYJRE6KWSBF
X-Message-ID-Hash: 5M5VXLFGODS7JIH4E4CPOYYJRE6KWSBF
X-MailFrom: evyncke@cisco.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: "draft-ietf-bpf-isa@ietf.org" <draft-ietf-bpf-isa@ietf.org>,
 "bpf-chairs@ietf.org" <bpf-chairs@ietf.org>, "bpf@ietf.org" <bpf@ietf.org>,
 "void@manifault.com" <void@manifault.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_BPF/eBPF_non-acronym_feedback_from_Gunter_Van_de_V?=
 =?utf-8?q?elde_and_=C3=89ric_Vyncke?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/i93lzdN3ewnzzS_JMbinCIYxAIU>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: multipart/mixed; boundary="===============4544192091742839944=="
X-Original-From: "Eric Vyncke (evyncke)" <evyncke@cisco.com>
From: "Eric Vyncke \(evyncke\)" <evyncke=40cisco.com@dmarc.ietf.org>

--===============4544192091742839944==
Content-Language: en-GB
Content-Type: multipart/alternative;
 boundary="_000_PH0PR11MB4966DACDD3F5F07C0B76C022A9C92PH0PR11MB4966namp_"

--_000_PH0PR11MB4966DACDD3F5F07C0B76C022A9C92PH0PR11MB4966namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Dave

I knew the story but thanks for the added pieces of information.

As you wrote, this may be useful to include this I-D is linked to the eBPF =
that you know and love. Especially for this ISA draft, the first one, as it=
 is the first time IETF does some eBPF standardization.

Of course, if this I-D is followed by more in the coming years, there will =
be less need to add this short explanation.

Regards

-=E9ric

From: Dave Thaler <dthaler1968@googlemail.com>
Date: Thursday, 20 June 2024 at 21:58
To: Eric Vyncke (evyncke) <evyncke@cisco.com>, gunter.van_de_velde@nokia.co=
m <gunter.van_de_velde@nokia.com>
Cc: draft-ietf-bpf-isa@ietf.org <draft-ietf-bpf-isa@ietf.org>, bpf-chairs@i=
etf.org <bpf-chairs@ietf.org>, bpf@ietf.org <bpf@ietf.org>, void@manifault.=
com <void@manifault.com>, bpf@vger.kernel.org <bpf@vger.kernel.org>
Subject: BPF/eBPF non-acronym feedback from Gunter Van de Velde and =C9ric =
Vyncke
Gunter Van de Velde, RTG AD, wrote:
> > 12 eBPF (which is no longer an acronym for anything), also commonly
>
> I assumed that 'e' was for 'extended' and that BPF stands for 'BSD Packet
> Filter' originally described and specified in a paper titled "The BSD
> Packet Filter: A New Architecture for User-level Packet Capture" by
> Steven McCanne and Van Jacobson, presented at the 1993 Winter
> USENIX Conference. This paper introduced the BPF architecture, which
> was designed for efficient packet filtering and capture.
>
> Hence a bit surprised why the first words of the first line in
> the first paragraph of the draft abstract suggest that its
> not an acronym?

=C9ric Vyncke wrote:
> =C9ric Vyncke has entered the following ballot position for
> draft-ietf-bpf-isa-03: Yes
>
> When responding, please keep the subject line intact and reply to all ema=
il addresses
> included in the To and CC lines. (Feel free to cut this introductory para=
graph,
> however.)
>
>
> Please refer to https://www.ietf.org/about/groups/iesg/statements/handlin=
g-ballot-
> positions/
> for more information about how to handle DISCUSS and COMMENT positions.
>
>
> The document, along with other ballot positions, can be found here:
> https://datatracker.ietf.org/doc/draft-ietf-bpf-isa/
>
>
>
> ----------------------------------------------------------------------
> COMMENT:
> ----------------------------------------------------------------------
>
> Nice document, easy to read and understand and the shepherd's write-up
> companion is also clear.
>
> Just two COMMENTs (no need to reply, but replies will be appreciated):
>
> 1) like Gunter, having an expansion to "eBPF is related or is the success=
or of
> extended Berkeley Packet Filter" would comfort the readers about what the=
y are
> reading.

The existing text is derived from what is at https://ebpf.io/what-is-ebpf/
and a much longer exposition would be more appropriate for a different docu=
ment on the WG charter ("[I] an architecture and framework document").

However, https://ebpf.io/what-is-ebpf/#what-do-ebpf-and-bpf-stand-for does =
have the FAQ answer for "What do eBPF and BPF stand for?":

> BPF originally stood for Berkeley Packet Filter, but now that eBPF
> (extended BPF) can do so much more than packet filtering, the acronym
> no longer makes sense. eBPF is now considered a standalone term that
> doesn=92t stand for anything. In the Linux source code, the term BPF
> persists, and in tooling and in documentation, the terms BPF and eBPF
> are generally used interchangeably. The original BPF is sometimes
> referred to as cBPF (classic BPF) to distinguish it from eBPF.

That paragraph, or some variation of it, would in my opinion be appropriate
in the architecture/ framework document, but do we really want it in *every=
*
other document from the WG?  That would seem needlessly redundant to me.

There are plenty of examples in the world of things that started as acronym=
s
and no longer stand for anything and so are not expanded (AT&T,
NPR, CBS, 3M, SOS, etc.)   See
http://blog.writeathome.com/index.php/2013/10/12-initials-that-stand-for-no=
thing/
for one of many articles with a list of such terms, but web searches will t=
urn
up plenty of other references.

Trying to explain in every news article that uses
one of those terms what it originally stood for but doesn't any more, doesn=
't
seem particularly helpful to me and certainly isn't commonly done.

Dave

--_000_PH0PR11MB4966DACDD3F5F07C0B76C022A9C92PH0PR11MB4966namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-BE" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">Dave<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">I knew the story but thanks for the added pieces of =
information.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">As you wrote, this may be useful to include this I-D=
 is linked to the eBPF that you know and love. Especially for this ISA draf=
t, the first one, as it is the first time
 IETF does some eBPF standardization.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">Of course, if this I-D is followed by more in the co=
ming years, there will be less need to add this short explanation.<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US">-=E9ric<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;mso-f=
areast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:36.0pt">
<b><span style=3D"color:black">From: </span></b><span style=3D"color:black"=
>Dave Thaler &lt;dthaler1968@googlemail.com&gt;<br>
<b>Date: </b>Thursday, 20 June 2024 at 21:58<br>
<b>To: </b>Eric Vyncke (evyncke) &lt;evyncke@cisco.com&gt;, gunter.van_de_v=
elde@nokia.com &lt;gunter.van_de_velde@nokia.com&gt;<br>
<b>Cc: </b>draft-ietf-bpf-isa@ietf.org &lt;draft-ietf-bpf-isa@ietf.org&gt;,=
 bpf-chairs@ietf.org &lt;bpf-chairs@ietf.org&gt;, bpf@ietf.org &lt;bpf@ietf=
.org&gt;, void@manifault.com &lt;void@manifault.com&gt;, bpf@vger.kernel.or=
g &lt;bpf@vger.kernel.org&gt;<br>
<b>Subject: </b>BPF/eBPF non-acronym feedback from Gunter Van de Velde and =
=C9ric Vyncke<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:0cm;margin-right:0cm;mar=
gin-bottom:12.0pt;margin-left:36.0pt">
<span style=3D"font-size:11.0pt">Gunter Van de Velde, RTG AD, wrote:<br>
&gt; &gt; 12 eBPF (which is no longer an acronym for anything), also common=
ly<br>
&gt;<br>
&gt; I assumed that 'e' was for 'extended' and that BPF stands for 'BSD Pac=
ket<br>
&gt; Filter' originally described and specified in a paper titled &quot;The=
 BSD<br>
&gt; Packet Filter: A New Architecture for User-level Packet Capture&quot; =
by<br>
&gt; Steven McCanne and Van Jacobson, presented at the 1993 Winter<br>
&gt; USENIX Conference. This paper introduced the BPF architecture, which<b=
r>
&gt; was designed for efficient packet filtering and capture.<br>
&gt;<br>
&gt; Hence a bit surprised why the first words of the first line in<br>
&gt; the first paragraph of the draft abstract suggest that its<br>
&gt; not an acronym?<br>
<br>
=C9ric Vyncke wrote: <br>
&gt; =C9ric Vyncke has entered the following ballot position for<br>
&gt; draft-ietf-bpf-isa-03: Yes<br>
&gt; <br>
&gt; When responding, please keep the subject line intact and reply to all =
email addresses<br>
&gt; included in the To and CC lines. (Feel free to cut this introductory p=
aragraph,<br>
&gt; however.)<br>
&gt; <br>
&gt; <br>
&gt; Please refer to <a href=3D"https://www.ietf.org/about/groups/iesg/stat=
ements/handling-ballot-">
https://www.ietf.org/about/groups/iesg/statements/handling-ballot-</a><br>
&gt; positions/<br>
&gt; for more information about how to handle DISCUSS and COMMENT positions=
.<br>
&gt; <br>
&gt; <br>
&gt; The document, along with other ballot positions, can be found here:<br=
>
&gt; <a href=3D"https://datatracker.ietf.org/doc/draft-ietf-bpf-isa/">https=
://datatracker.ietf.org/doc/draft-ietf-bpf-isa/</a><br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
<br>
&gt; COMMENT:<br>
&gt; ----------------------------------------------------------------------=
<br>
&gt; <br>
&gt; Nice document, easy to read and understand and the shepherd's write-up=
<br>
&gt; companion is also clear.<br>
&gt; <br>
&gt; Just two COMMENTs (no need to reply, but replies will be appreciated):=
<br>
&gt; <br>
&gt; 1) like Gunter, having an expansion to &quot;eBPF is related or is the=
 successor of<br>
&gt; extended Berkeley Packet Filter&quot; would comfort the readers about =
what they are<br>
&gt; reading.<br>
<br>
The existing text is derived from what is at <a href=3D"https://ebpf.io/wha=
t-is-ebpf/">
https://ebpf.io/what-is-ebpf/</a><br>
and a much longer exposition would be more appropriate for a different docu=
ment on the WG charter (&quot;[I] an architecture and framework document&qu=
ot;).<br>
<br>
However, <a href=3D"https://ebpf.io/what-is-ebpf/#what-do-ebpf-and-bpf-stan=
d-for">https://ebpf.io/what-is-ebpf/#what-do-ebpf-and-bpf-stand-for</a> doe=
s have the FAQ answer for &quot;What do eBPF and BPF stand for?&quot;:<br>
<br>
&gt; BPF originally stood for Berkeley Packet Filter, but now that eBPF<br>
&gt; (extended BPF) can do so much more than packet filtering, the acronym<=
br>
&gt; no longer makes sense. eBPF is now considered a standalone term that<b=
r>
&gt; doesn=92t stand for anything. In the Linux source code, the term BPF<b=
r>
&gt; persists, and in tooling and in documentation, the terms BPF and eBPF<=
br>
&gt; are generally used interchangeably. The original BPF is sometimes<br>
&gt; referred to as cBPF (classic BPF) to distinguish it from eBPF.<br>
<br>
That paragraph, or some variation of it, would in my opinion be appropriate=
<br>
in the architecture/ framework document, but do we really want it in *every=
*<br>
other document from the WG?&nbsp; That would seem needlessly redundant to m=
e.<br>
<br>
There are plenty of examples in the world of things that started as acronym=
s<br>
and no longer stand for anything and so are not expanded (AT&amp;T,<br>
NPR, CBS, 3M, SOS, etc.)&nbsp;&nbsp; See<br>
<a href=3D"http://blog.writeathome.com/index.php/2013/10/12-initials-that-s=
tand-for-nothing/">http://blog.writeathome.com/index.php/2013/10/12-initial=
s-that-stand-for-nothing/</a><br>
for one of many articles with a list of such terms, but web searches will t=
urn<br>
up plenty of other references.<br>
<br>
Trying to explain in every news article that uses<br>
one of those terms what it originally stood for but doesn't any more, doesn=
't<br>
seem particularly helpful to me and certainly isn't commonly done.<br>
<br>
Dave<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH0PR11MB4966DACDD3F5F07C0B76C022A9C92PH0PR11MB4966namp_--


--===============4544192091742839944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

LS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

--===============4544192091742839944==--


