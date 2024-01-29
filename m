Return-Path: <bpf+bounces-20566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7696784049C
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA483B21FA2
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2F360259;
	Mon, 29 Jan 2024 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="g0fQxhHk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="g0fQxhHk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rnaa/Gz2";
	dkim=neutral (0-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="roDgYrUK"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9CA5FF0A
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=50.223.129.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530092; cv=fail; b=f1GBpVDy7renJ2yWR27Q8OPRY9V44Qc2Ei6BbeMBrLJCETRDsz6WG/BSTIDWb0k/pDajZi1agmmVJPIDz7TjVesJl4yEzHJ6tP3f9hUYFr6R5ggxHAnQXEledIERdQNtTtIxjDVg6hh28O6yxoLPTFKQXoWnZUTrB78s3X3Xpvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530092; c=relaxed/simple;
	bh=SPGpfiVV+pZR763ZyEDc5efOB+aJlPVAa0B+ZomtuBE=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Subject:Content-Type; b=XBHIPDNFIPkRBBz8cYQrI1oyOf1qZFWIHiJbQyWPCkngb4gorcwbCmV5iVGHYksQk73JhNcjHN1K9vuxfLgJncIs5v5dp9MR2uFnvLQ/xfrImZFYEZmkECRbZ5kYuNf2taHAVgHSdHCvRF4MEpQ1MDHxRvilSnwOrbAgZQ5rVe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=g0fQxhHk; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=g0fQxhHk; dkim=fail (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rnaa/Gz2 reason="signature verification failed"; dkim=neutral (0-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=roDgYrUK; arc=fail smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5ADFFC14CF0C
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706530084; bh=SPGpfiVV+pZR763ZyEDc5efOB+aJlPVAa0B+ZomtuBE=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=g0fQxhHkOyfFZc03zgTzzeCMC114xTq71QIpy/VBtZCi9zCc717Yu65RvX04VesyQ
	 LhGDbK8ZbXd3eR0d/Lg32y/GZc+1Vpc90vWx0mANuAi9gW2pddfmhVVXc7VAwUzrb/
	 u1PZOxpDgRgtcUZj/ZPH8oBqoGNdZRGoN91thvgc=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jan 29 04:08:04 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 187BEC14F690;
	Mon, 29 Jan 2024 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706530084; bh=SPGpfiVV+pZR763ZyEDc5efOB+aJlPVAa0B+ZomtuBE=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=g0fQxhHkOyfFZc03zgTzzeCMC114xTq71QIpy/VBtZCi9zCc717Yu65RvX04VesyQ
	 LhGDbK8ZbXd3eR0d/Lg32y/GZc+1Vpc90vWx0mANuAi9gW2pddfmhVVXc7VAwUzrb/
	 u1PZOxpDgRgtcUZj/ZPH8oBqoGNdZRGoN91thvgc=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 41E8BC14F690
 for <bpf@ietfa.amsl.com>; Mon, 29 Jan 2024 04:08:03 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.105
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=oracle.com header.b="Rnaa/Gz2";
 dkim=pass (1024-bit key)
 header.d=oracle.onmicrosoft.com header.b="roDgYrUK"
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BSM-CSdsNJ5V for <bpf@ietfa.amsl.com>;
 Mon, 29 Jan 2024 04:07:59 -0800 (PST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 3E17DC14F682
 for <bpf@ietf.org>; Mon, 29 Jan 2024 04:07:59 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T9i6NC003240; Mon, 29 Jan 2024 12:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hZRGNtLOhgblH1+t8eCMo1C+kMeKiaU8Dgm5B+HrzYc=;
 b=Rnaa/Gz2/g7hHy4ZN48A6SzBYlp+ozpwqYuc4cz9+gLHrWRVBFLjvHMUuMvam7ybLg5B
 wdn/XAEn0K0eJNC1MoHoQyFl9NCzCb2L6IJKqpuCFTZhM+g0O3jvzqzAscPwHT6QXe1r
 Vdn9Hk14E5gsKgVQ9lWf2xDpmhMyQsCnG7clLJGWlRv5tLOqaRoKj/+9I2svie5x3/LA
 9qoitbgfC2EjvHhj1Vyky/RRbubvLlzowsnrvl5nQ+DCPu3cjDRYveDPXR4QoUqkntzR
 dOiC82vtfpKgDx+itNYCLdgo9L/0WID0Xvu6n+iRmpkRvpSwB5QIqS3STRE8i7HpIJaz gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2bqp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 12:07:55 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40TB2sJ3031469; Mon, 29 Jan 2024 12:07:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr95sh7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 12:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWAQmNW2/6NwFsKpp2fL71uWBDwCCpZ5iXp27KVND6j86AMdJnzm8pBVOJ3QOHaFLH2F8AppWyQG4dAEx5aLp6NagPr2hcTlaCRObZPUXUh0Ror0FD2gfIPtasXTXrTaRmNLfii7/S3+l4lWusDus1xDUfr27yqIDUBafd7aTfNNXW5ozcxCNWEJLxCDS7fwygJXcazmvNaUiHOUX9DD5BCawaviGtUM7z6SdVUpQZZbc3TaPxniIrN3aZBXDmLBWUxS6AhHky/Ts+CFeV78cm10UzYDH8cD8d/295VcmwlErXji6ki/8qBaa91Rid9EGuU16wNvK4UGOMjiLZC9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZRGNtLOhgblH1+t8eCMo1C+kMeKiaU8Dgm5B+HrzYc=;
 b=dzOx2+B0k1U4337059a7StCUQkl1ue6EKcVWJ/QTxCRDKeJALQkNUHYTBPQTvJw7xEc+n/TlIpKiGXMSoCjZYYsWLjPMdJhlOGn/oBVLEBxlnijDtYvnOD0jVVzgWQjbM98BdsdUUu2nqKkECJA7Wq5u3HoKZCJ3JHr1kIS9q2fUib1ooTOwiWhPa6qgLrJANwNRgWR+28KtEdxUJcLeUXpRIp6TUH3CyUBJSi9lC2bgt9i1o4yVGe15C49M5iNuaJQ6Euvaq5NEnxRcPx64Dv2Y8Xaeb85gVDbSF0XBKVDOfCTONNcT9B4RlrtH8Ugphd3+50sSHELQ9HtHlCFibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZRGNtLOhgblH1+t8eCMo1C+kMeKiaU8Dgm5B+HrzYc=;
 b=roDgYrUKR3p9P/+schLM9d53Ot2aa4uyqlwy5rKEEPXPuGWm3drrcOUKjrKoeWrvZu/DcrzVnFchEc7d0NW7Lm2UKXUEcT11u47NZ7kHo6X2tIskC01q6y5V+K4eooqX5wA7sMZwHpwFINzfM9NerDDo3smJR7htR4yTheFFEac=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 12:07:52 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 12:07:52 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@ietf.org, bpf <bpf@vger.kernel.org>
In-Reply-To: <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
 (Alexei Starovoitov's message of "Sun, 28 Jan 2024 15:59:48 -0800")
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
 <877cjutxe9.fsf@oracle.com> <8734uitx3m.fsf@oracle.com>
 <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
 <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
Date: Mon, 29 Jan 2024 13:07:49 +0100
Message-ID: <87plxkqr56.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-ClientProxiedBy: FR0P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::9) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfdaffe-bb40-4ff4-29ee-08dc20c2eb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvcvcFfXPxZVG/xggVRaUsL0LubSsP7jl8TxrV+wDklaoX8UEvlac/k/hCMrtp44igedGM0v3UKZEWjG33h8AHagFl2WKMRRcMmXLN0IDouFgWhXScnOkWSpxO9YJvVV0L6ijL0MAN9164QLCmS/jeKs62UEcg6x6VSJFsxvrHouHx86Dy8TyN8Fwj/fJ+dhKjxY/bqQGqf+PJhleGqZf5viyn2/9qk5lCfUKkf6Q6w0KHvzLAg9sQptoWWDjxOA/DlRqwU6tldxsj/KQZ7Kz16I87m441YEsyLdaIu208ZVm8L6o77zuKkPFfkvKnlyL4fmPG+1vkLPTfzY9zf6R8MLqjRLWG2VIc01z14CBzf7Af9Z1EKzbApPHX2DC42Q4BJsDEmQFp3wjb5Q8S4zF4D4sJYEpUZioIMbG6bHhsPVWLbNWNFO/a13KaRzDUCs/XD3cW1wAeyRRzc7+6OjJMh4SXSu2YmnLN4uH2QCcNSfFu5l55/lmwu6d3RLTGQfY1BY/rYEkcz01lXzVYoVFfl3HnAvGC6fc1UNUCpDsb1znenoGqqMItcPzgWb8vTo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB3113.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(316002)(2616005)(6512007)(6506007)(66476007)(66946007)(66556008)(54906003)(6916009)(8936002)(8676002)(38100700002)(4326008)(6486002)(26005)(53546011)(478600001)(6666004)(2906002)(5660300002)(41300700001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFB0eGg5MndLdC90Y3EvbGl4ckRYN09CVGpNOS9yOThDZzVZY21MR0ViUmN3?=
 =?utf-8?B?VEZOWE9FL204cHc3bXExb0h5Y3dWWGJuaEdXem5nQ0lPeTM3UFFkQVpwMTNv?=
 =?utf-8?B?VUIzeUNyVnJnMUNhSzhRVkFSekNBNUhsVlRYMTU4NDZybENNSDQ4VTM1TS9P?=
 =?utf-8?B?eS9GQzBidjVPaFZITDR2OFdCV1RYaEJwR3RIZVBPUENLQVNYdkZFVmRXclQ0?=
 =?utf-8?B?WUd3bEk1aHY4N0JyOHdMS05pQU9vZnlKTjJJMm8vQ3VYQkZlb3N2RDdGeHRK?=
 =?utf-8?B?NFppeGkvUHNMRit3RklWTDZQcy9pME54NGdtUzJRa0dXaC9PREJMeUhHdHBY?=
 =?utf-8?B?NXNBcGNLckpDUEVZaC82Vzd4U0ZHeWNHc0VrNjJSZjVwc1V3VStUZFYxLzFo?=
 =?utf-8?B?TXJWVTRjbFlScGQzOUtsZTBzbmpLYVgyOXFqd0RFd2p5dXBTcVFsMWJXSDRR?=
 =?utf-8?B?VWtQTUgwSEZzOUsvOW81K1FPKy9DMUN3U0hCbnZVR0lDa2syMVZjT2JOeFJl?=
 =?utf-8?B?ZVNYalY2dGRlNzl2SE16US9lTzBQSCtSOTZ0RUxiYnBKRWxJb0tkRUFXSUFW?=
 =?utf-8?B?dEZSNGplRVhEQlZkS3pvemxYL1oyZUtyTEVGTUtqZEE0Yk1sRVY4c2RPekhJ?=
 =?utf-8?B?bDUvcGNiTElWSzNDdmFZaTBEejdJc0VCclZRQXdrZ0NOUFF2YzVmZ0g2S2FU?=
 =?utf-8?B?WUdMdXVZZm4zTGNUOERzNkdHUnFiV2lJQ1NuRmhmMngrQUxzMnltSUZyTzFQ?=
 =?utf-8?B?WXpDaENuZ01GcGJtdGV4V1FVU1F1UFMwdWdxNFVxc0NDcktidWtZZWNCeGZZ?=
 =?utf-8?B?SU9FTmlndG9zTDRvZlhvMTBUMUhoaCtrd3AzbElDaWg1d09xWGRwSE5VWUFX?=
 =?utf-8?B?NnR5WWNJNXFEcU1nWTh5ZWc1bUlEYlBPQlozOWRXeXN2YkhJdi9yK1U5Rnl1?=
 =?utf-8?B?YW9ucWREUkVCbGR3OVVTUTdZRGpaWDU4cVBQMS9haVRERTY5NTRrVWVPVW1G?=
 =?utf-8?B?NVBSQmo0OUNMR0RNblpKNDNjOTBMWnczV3IwUXJuejZLM1R4T1VIM3hkUzRM?=
 =?utf-8?B?a0did2N5ek5DZ3B0TjZmUXljdmtBQVJGZGNJMlJsaEhYNmlWdC84aEE0ZTd3?=
 =?utf-8?B?cFN3cllHTkRqK3RYcXl2ZVV1US9hZlhyTTlveVVQSUNWQ1VMK3J5MXZGRXNh?=
 =?utf-8?B?RXdWR3ZvMGpZK0hHdWdkY0JKeHJRTUpoWUpHSFo5azJ4VC9LUHozQXY5UENQ?=
 =?utf-8?B?UVVMMSs3bjFZRldpWHBBTDNWNWo3SS9lZDNkb0d1R2ZnSlpmN2VzdlJlT3Fa?=
 =?utf-8?B?RFJlN21SZGI2emcwSVdoZ2l6NGpJUUJLVWhvQjVmRUpySUdqRWhES1RnOStR?=
 =?utf-8?B?cFlFaHlkZkxtN2dHT2ttL2hmQklVdTlBQWxUcjBzU2creFpMVmQyY2NJckJr?=
 =?utf-8?B?TkRzdWl5RWZLdk5hQ0xMeGZVN0NlZExqbXA0UHN6b1I2VnJYWVBsUEMzelRN?=
 =?utf-8?B?cmI1TGVEQmJWWVQrMnZoNWZJdTFzRmNCU1FOV0FWeVZSNnFWckhMZHhFMGsw?=
 =?utf-8?B?dHdJcjZ1VStCY3JONFF4bFVOMUlUOXdUWXUzWWp0TWpSYitCK2wxUU1KMUR3?=
 =?utf-8?B?U2pCTjR4RkYwNjZJTXZKNTZPeE9tMHNSNUo0d2JlUzFKM29jQ0xGWXNLUW8y?=
 =?utf-8?B?TzNINzJab3ZrcFIxYkdhZkNWV1ZIVTgzZUZrNVF0bHU2dmVYcC9PN01MRFIr?=
 =?utf-8?B?SzhyZDFtbmJsNjAycnhpUFErN241VWZ1Wm90bkFoUVJBc2xqSCtKQ3BEZnpQ?=
 =?utf-8?B?bXpTSDhYQlFEaHU2ODUvbUprcXByQUs2QnJ3N3dyditObTZHamRRMXAycDJ3?=
 =?utf-8?B?UklPNjVQYVRqcnJRYVJwU0VzRWVWKzV2UEU4S21lajlSaGgwRGQ2SDhOQXQw?=
 =?utf-8?B?Y0N2aU9Ob2ZSc0Yrd1lXTndrTjR5NThyVUZJV1N2MTFwSnBBdWc2bDdyWmxN?=
 =?utf-8?B?YjJLNjVJQjdqWHNIK1FPYkZjNEpwbjlIa0ZaSlpSUDl3TTdCazVpVU1ONHN4?=
 =?utf-8?B?dGM1ZzVSTHdIWVhWRm5zV2ptaWxnRU1wQUFuQmZLVmVoRVNtdGNVOHZNYjBL?=
 =?utf-8?B?bkczYzZHbkFOckpiSjh1TUJXc0EvejJsNnJkOVgrRThNcXNnbUpNOUN5T2Zm?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CAbZ6uJDvoKbxP878wdiPYqFMEmsXWOQLVpH6vfFqjZd9zIjOnvXNTgPIFQl1DBx9sjLtslL8lcTEGxiCUx4IMnOkkUAGHdVM0RL0S7FT5s0bYEMVGOZj4y5WtxnT462Fq8hNQAS3OR8dcmT3W8HBb+IPNLDFLyTm3U5f2vBj48PMCnArROtOG9zRqh2KvjtCahoKuw8RAu/ZCS4ScWY7+HXRmNOWbnBVRZOdArPdkGx1l2Ps79XbHM+Zs6o/ls5hXMrGO3HqSbT7I0QMPR5/4AFtZGBWlkHDNfRlARdeMhMbr05PfI2KK89xf0V/TIlO0VQCX/Iqv7zmmh1KzTxCE4PRhWLTAuWzwJDUb5d5KRQ86xh2Gzey3zzgktx/2wAPq+4wyfvn2qNT1TFDiF2m/L48wtNy9ZAH4AWJ4U4XZ9HxuLe8bri3/2mRWWnn+gExqktZoCt6L3RnYC1WpZuXUJwuc44F4uk4oXSUuedC4toHK2M2+m1r+P7qZzkG1Vv/Mdzb3s8XeE6NpPWLx8Leb+Hajbn5YBRBbiWdx9aYXexz93kpRmlk4Y+zAJl4Zgr+ohb127rvGLTsKi8KqZXNyPpGHaQS2La8YRde/mvWHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfdaffe-bb40-4ff4-29ee-08dc20c2eb80
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:07:52.8125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMN6X6LMpqVArvB8Aqm53kqf3ZeWrZADiBwrF5kyQytr5lHl1YVJTIIwoqP0uDLSdIa7/0rBgKUHjPCgPacQLMrw3FYW3iSeFHW9ZbiX920=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290088
X-Proofpoint-GUID: k6Z_J_XzCtOglK1ALYlIBTpHRSPhkoWY
X-Proofpoint-ORIG-GUID: k6Z_J_XzCtOglK1ALYlIBTpHRSPhkoWY
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/8SXhqBu9h5hS1dPZESJVMgXfEco>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

Cj4gT24gU2F0LCBKYW4gMjcsIDIwMjQgYXQgMTA6NTnigK9QTSA8ZHRoYWxlcjE5NjhAZ29vZ2xl
bWFpbC5jb20+IHdyb3RlOgo+Pgo+PiBJIGFza2VkOgo+PiA+ID4+IFdoYXQgYWJvdXQgRFcgYW5k
IExEWCB2YXJpYW50cyBvZiBCUEZfSU5EIGFuZCBCUEZfQUJTPwo+Pgo+PiBKb3NlIEUuIE1hcmNo
ZXNpIDxqb3NlLm1hcmNoZXNpQG9yYWNsZS5jb20+IHdyb3RlOgo+PiA+IFRoZXNlIHdlIHN1cHBv
cnQ6Cj4+ID4KPj4gPiAgIC8qIEFic29sdXRlIGxvYWQgaW5zdHJ1Y3Rpb25zLCBkZXNpZ25lZCB0
byBiZSB1c2VkIGluIHNvY2tldCBmaWx0ZXJzLgo+PiAqLwo+PiA+ICAge0JQRl9JTlNOX0xEQUJT
QiwgImxkYWJzYiVXJWkzMiIsICJyMCA9ICogKCB1OCAqICkgc2tiIFsgJWkzMiBdIiwKPj4gPiAg
ICBCUEZfVjEsIEJQRl9DT0RFLCBCUEZfQ0xBU1NfTER8QlBGX1NJWkVfQnxCUEZfTU9ERV9BQlN9
LAo+PiA+ICAge0JQRl9JTlNOX0xEQUJTSCwgImxkYWJzaCVXJWkzMiIsICJyMCA9ICogKCB1MTYg
KiApIHNrYiBbICVpMzIgXSIsCj4+ID4gICAgQlBGX1YxLCBCUEZfQ09ERSwgQlBGX0NMQVNTX0xE
fEJQRl9TSVpFX0h8QlBGX01PREVfQUJTfSwKPj4gPiAgIHtCUEZfSU5TTl9MREFCU1csICJsZGFi
c3clVyVpMzIiLCAicjAgPSAqICggdTMyICogKSBza2IgWyAlaTMyIF0iLAo+PiA+ICAgIEJQRl9W
MSwgQlBGX0NPREUsIEJQRl9DTEFTU19MRHxCUEZfU0laRV9XfEJQRl9NT0RFX0FCU30sCj4+ID4g
ICB7QlBGX0lOU05fTERBQlNEVywgImxkYWJzZHclVyVpMzIiLCAicjAgPSAqICggdTY0ICogKSBz
a2IgWyAlaTMyIF0iLAo+PiA+ICAgIEJQRl9WMSwgQlBGX0NPREUsIEJQRl9DTEFTU19MRHxCUEZf
U0laRV9EV3xCUEZfTU9ERV9BQlN9LAo+PiA+Cj4+ID4gICAvKiBHZW5lcmljIGxvYWQgaW5zdHJ1
Y3Rpb25zICh0byByZWdpc3Rlci4pICAqLwo+PiA+ICAge0JQRl9JTlNOX0xEWEIsICJsZHhiJVcl
ZHIgLCBbICVzciAlbzE2IF0iLCAiJWRyID0gKiAoIHU4ICogKSAoICVzciAlbzE2Cj4+ICkiLAo+
PiA+ICAgIEJQRl9WMSwgQlBGX0NPREUsIEJQRl9DTEFTU19MRFh8QlBGX1NJWkVfQnxCUEZfTU9E
RV9NRU19LAo+PiA+ICAge0JQRl9JTlNOX0xEWEgsICJsZHhoJVclZHIgLCBbICVzciAlbzE2IF0i
LCAiJWRyID0gKiAoIHUxNiAqICkgKCAlc3IKPj4gJW8xNgo+PiA+ICkiLAo+PiA+ICAgIEJQRl9W
MSwgQlBGX0NPREUsIEJQRl9DTEFTU19MRFh8QlBGX1NJWkVfSHxCUEZfTU9ERV9NRU19LAo+PiA+
ICAge0JQRl9JTlNOX0xEWFcsICJsZHh3JVclZHIgLCBbICVzciAlbzE2IF0iLCAiJWRyID0gKiAo
IHUzMiAqICkgKCAlc3IKPj4gJW8xNgo+PiA+ICkiLAo+PiA+ICAgIEJQRl9WMSwgQlBGX0NPREUs
IEJQRl9DTEFTU19MRFh8QlBGX1NJWkVfV3xCUEZfTU9ERV9NRU19LAo+PiA+ICAge0JQRl9JTlNO
X0xEWERXLCAibGR4ZHclVyVkciAsIFsgJXNyICVvMTYgXSIsIiVkciA9ICogKCB1NjQgKiApICgg
JXNyCj4+ID4gJW8xNiApIiwKPj4gPiAgICBCUEZfVjEsIEJQRl9DT0RFLCBCUEZfQ0xBU1NfTERY
fEJQRl9TSVpFX0RXfEJQRl9NT0RFX01FTX0sCj4+Cj4+IFlvbmdob25nIFNvbmcgPHlvbmdob25n
LnNvbmdAbGludXguZGV2PiB3cm90ZToKPj4gPiBJIGRvbid0IGtub3cgaG93IHRvIGRvIHByb3Bl
ciB3b3JkaW5nIGluIHRoZSBzdGFuZGFyZC4gQnV0IERXIGFuZCBMRFgKPj4gPiB2YXJpYW50cyBv
ZiBCUEZfSU5EL0JQRl9BQlMgYXJlIG5vdCBzdXBwb3J0ZWQgYnkgdmVyaWZpZXIgZm9yIG5vdyBh
bmQgdGhleQo+PiA+IGFyZSBjb25zaWRlcmVkIGlsbGVnYWwgaW5zbnMuCj4+Cj4+IEFsdGhvdWdo
IHRoZSBMaW51eCB2ZXJpZmllciBkb2Vzbid0IHN1cHBvcnQgdGhlbSwgdGhlIGZhY3QgdGhhdCBn
Y2MgZG9lcwo+PiBzdXBwb3J0Cj4+IHRoZW0gdGVsbHMgbWUgdGhhdCBpdCdzIHByb2JhYmx5IHNh
ZmVzdCB0byBsaXN0IHRoZSBEVyBhbmQgTERYIHZhcmlhbnRzIGFzCj4+IGRlcHJlY2F0ZWQgYXMg
d2VsbCwgd2hpY2ggaXMgd2hhdCB0aGUgZHJhZnQgYWxyZWFkeSBkaWQgaW4gdGhlIGFwcGVuZGl4
IHNvCj4+IHRoYXQncyBnb29kIChub3RoaW5nIHRvIGNoYW5nZSB0aGVyZSwgSSB0aGluaykuCj4K
PiBEVyBuZXZlciBleGlzdGVkIGluIGNsYXNzaWMgYnBmLCBzbyBhYnMvaW5kIG5ldmVyIGhhZCBE
VyBmbGF2b3IuCj4gSWYgc29tZSBhc3NlbWJsZXIvY29tcGlsZXIgZGVjaWRlZCB0byAic3VwcG9y
dCIgdGhlbSBpdCdzIG9uIHRoZW0uCj4gVGhlIHN0YW5kYXJkIG11c3Qgbm90IGxpc3Qgc3VjaCB0
aGluZ3MgYXMgZGVwcmVjYXRlZC4gVGhleSBuZXZlcgo+IGV4aXN0ZWQuIFNvIG5vdGhpbmcgaXMg
ZGVwcmVjYXRlZC4KCldlIGhhdmUgbm8gcmVhc29uIHRvIHN1cHBvcnQgdGhlc2UgaW5zdHJ1Y3Rp
b25zIGluIHRoZSBhc3NlbWJsZXIsIGFuZApHQ0MgY2VydGFpbmx5IG5ldmVyIGdlbmVyYXRlcyB0
aGVzZS4gIFNvIEkgd2lsbCByZW1vdmUgdGhlIEFCUy9JTkQgRFcKaW5zdHJ1Y3Rpb25zIGZyb20g
dGhlIGFzc2VtYmxlciB0b2RheS4KCj4gU2FtZSB3aXRoIE1TSC4gQlBGX0xEWCB8IEJQRl9NU0gg
fCBCUEZfQiBpcyB0aGUgb25seSBpbnNuIGV2ZXIgZXhpc3RlZC4KPiBJdCdzIGEgbGVnYWN5IGlu
c24uIEp1c3QgbGlrZSBhYnMvaW5kLgoKLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBmQGlldGYub3Jn
Cmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

