Return-Path: <bpf+bounces-30349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F010F8CCA25
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 02:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF39282341
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 00:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AED15CE;
	Thu, 23 May 2024 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b="yVtsWSWP";
	dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b="EaW8Mkii"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-003cac01.pphosted.com (mx0a-003cac01.pphosted.com [205.220.161.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547A1852;
	Thu, 23 May 2024 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.161.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716425083; cv=fail; b=djnkmIbipm5vfeQRViNkvaGgxbsBpPBFO1Gh9S6RxkqpNpurCHcHfEdzBPSIgT57mMZtnjfGPpLthesFA3CRm/1eZ92KFGzOWfGR9TooR3zVnubtjLSn3PfJvrQ7NqMhxByNJL1hAjTP60pTWPpXw2X0vpyO7APpbs6bJIgh+Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716425083; c=relaxed/simple;
	bh=flPVuiVRt1YrDHGU1qnOZ2nbmSbAcB4IVQ0zjv+s65E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OtQuFb7FbBk6Y8/emojxsoG4m/nVdCx1Y6W1Os5wdPXpe6qBDR/3Ef6hef9cr0fGkqX5eW6XltM+l2RBDUTfulnWq222/4UgRzJx/O8R5p0x+AU4ElAwGiQFa0seftdUcfe7mARakVSNoF22Tuuq0/HSmb2ilVnRmO91PwvYA5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com; spf=pass smtp.mailfrom=keysight.com; dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b=yVtsWSWP; dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b=EaW8Mkii; arc=fail smtp.client-ip=205.220.161.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=keysight.com
Received: from pps.filterd (m0187212.ppops.net [127.0.0.1])
	by mx0b-003cac01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44N0PO6u026543;
	Wed, 22 May 2024 17:44:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=ppfeb2020;
 bh=flPVuiVRt1YrDHGU1qnOZ2nbmSbAcB4IVQ0zjv+s65E=;
 b=yVtsWSWP2TDeoRgemmED1trrdlayUX3CqNQHsv7JdLnTS8bTT7BNocKctttNusyexx2w
 APvxMlhIOxv4Q2/naMpm160+rFqvqe3lx6YlI/V36DcvRa5wC84gpxeABBfxayGXyckd
 KAccuOiUlyivDEU4KfivtH70TCH2oGvKonWcKnjMH5Or0CeutgZ401+87eQM2RtdeLzU
 Lje9cbaKP8Q+/iXWAP7v7Ku5xQbPglBE2/FCeE/tK08Po8GNG6xYPTxd9TG9ho92KQEO
 W7Mv1q+trihO7uCBc+rrmdzkYKNsY4OLl/PqKVsoFfhiRaCHioVFgP3I2FFCx6XMF9AE ug== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 3y6rba1dta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 17:44:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzEojPfe8yxHgsAclEDDG+CkD5WSPrB4VscZQvZXO4AdOtP4hATEBFuGmCsnhxqyhD5Yl5uuYW1FlupybRau3JlAnfBw7nSQZ1e99F3580CJSIb8GM+kPZAjIYKkOrf5AfuSrRsNeQzzRdILQoltkASFIclI49JpCeHKNkB69A4czL0vkuPFM7Ir5eYa/nwpNgLmdXRwX7XoQH169ImIeyM0e5t3qbU1uoKLey9d/7oJJJYSYcAvuou4IFXpYe1zm65KQTBSqE+cfgW3we0Lmk5wOpvT4cVxiK+LHy42oCtYf9RC2tkxCxVgWvxIw6QgiKFKoHe07E4PT46WBpmjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flPVuiVRt1YrDHGU1qnOZ2nbmSbAcB4IVQ0zjv+s65E=;
 b=VT+zkaAXSB2Hj1reuTL7NTXDEyha1Oy54mDnWBnXv8u84txs4i7gmugzV/kPs7+gjb0PQLAgdsiOSol8dhsYly0QZFYstdPPwHRuc/tXJT20rmThMe1W2lN/u7+rO2sNmu1rD2a2b4OnV2KERthDe2Jz2IJVSrlKlM1L4l0csvuZbH0ONsATHS9zLA85kbzY19VEw2Rz0rZ4HhGaWe6Y8QlM18EG/EB4YIi+f8EomxWrS8iNr/ivgFsw/IRiUm/5MxEgT2B6oF2OscmaskFMantwYYJ8SozvOJ7TXIxPosW5iJlk1tV429bqfueBWjnmATP75OsH41Y7m/FduSQySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flPVuiVRt1YrDHGU1qnOZ2nbmSbAcB4IVQ0zjv+s65E=;
 b=EaW8MkiiwVnTy8ATbkxs0HquYR/f5xUE9QtFxw5257S4cnwiwwUcUikx4O1przUJrCfk3rJDZ/8mSILeY51HoyR1nJVS303fxBBLgysoHGRoMC3i4qkm4XvE94+wt3Yfd7AXF2yW2HnnGkEmPi4Nn1dQXbYMShyBNNee3OTdN98=
Received: from SN6PR17MB2110.namprd17.prod.outlook.com (2603:10b6:805:4e::33)
 by DS1PR17MB7278.namprd17.prod.outlook.com (2603:10b6:8:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 00:44:25 +0000
Received: from SN6PR17MB2110.namprd17.prod.outlook.com
 ([fe80::897f:512f:1cc5:c1c2]) by SN6PR17MB2110.namprd17.prod.outlook.com
 ([fe80::897f:512f:1cc5:c1c2%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 00:44:25 +0000
From: Chris Sommers <chris.sommers@keysight.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov
	<alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        "Chatterjee, Deb" <deb.chatterjee@intel.com>,
        Anjali Singhai Jain
	<anjali.singhai@intel.com>,
        "Limaye, Namrata" <namrata.limaye@intel.com>,
        tom
 Herbert <tom@sipanda.io>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        "Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>,
        "Osinski, Tomasz"
	<tomasz.osinski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>, Cong Wang
	<xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>,
        Simon Horman
	<horms@kernel.org>, Khalid Manaa <khalidm@nvidia.com>,
        =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Victor
 Nogueira <victor@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        "Jain, Vipin" <Vipin.Jain@amd.com>, "Daly, Dan" <dan.daly@intel.com>,
        Andy
 Fingerhut <andy.fingerhut@gmail.com>,
        Matty Kadosh <mattyk@nvidia.com>, bpf
	<bpf@vger.kernel.org>,
        "lwn@lwn.net" <lwn@lwn.net>
Subject: RE: On the NACKs on P4TC patches
Thread-Topic: On the NACKs on P4TC patches
Thread-Index: AQHaq3taEWM9VDh9Vkmz6Q1EN+6MvbGj1UeAgAAMQQCAABu3kA==
Date: Thu, 23 May 2024 00:44:25 +0000
Message-ID: 
 <SN6PR17MB21102057A1745DBCBB101DBB96F42@SN6PR17MB2110.namprd17.prod.outlook.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
 <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
 <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
 <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
 <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
 <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
 <CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com>
 <CAM0EoMmCz5usVSLq_wzR3s7UcaKifa-X58zr6hkPXuSBnwFX3w@mail.gmail.com>
 <CAM0EoMmsB5jHZ=4oJc_Yzm=RFDUHWh9yexdG6_bPFS4_CFuiog@mail.gmail.com>
 <20240522151933.6f422e63@kernel.org>
 <CAM0EoMmFrp5X5OzMbum5i_Bjng7Bhtk1YvWpacW6FV6Oy-3avg@mail.gmail.com>
In-Reply-To: 
 <CAM0EoMmFrp5X5OzMbum5i_Bjng7Bhtk1YvWpacW6FV6Oy-3avg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR17MB2110:EE_|DS1PR17MB7278:EE_
x-ms-office365-filtering-correlation-id: 35bbc54f-e348-4cd4-7c73-08dc7ac17ec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|366007|376005|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Zk1hRjIydXFMRXJBZlZSWk45MC9vZUtUSktKTXN0bGcwRXFWUUJySUFiczVR?=
 =?utf-8?B?OWlONDJRNDdoREg4RVpXVWVHS1ZMQm81aVNaUjhUNU9jdkxZT0FzckxkZDM0?=
 =?utf-8?B?amx0Z2dxK0FqbnlyMVZwTkUwRks1Um9SNGViWnJUQjBlQW40S0NSa2RGL25y?=
 =?utf-8?B?R0xjRjRTWlU1aFc0anFqTjNlSEpuZmxoZW9oTVJ5dVhqRUdNbHhkTnYzTmdE?=
 =?utf-8?B?SGFod1RzbzBsM0lRWVU4Y1NGR0MxL1BHQjhLdlVEanpNaTBybis4aGM2VHdi?=
 =?utf-8?B?TFJJQ1R4N2JQYnBQVkZ2eU5rV2JWQWs1UWRHQ2hiSXJQcXJOTklJRTBWUkpv?=
 =?utf-8?B?Q3pCZmJlTWUzNzFmcjlNSWc3Z1JZSzlUQlh6UW1NNzRPdjJGN1JiQk5iS1hN?=
 =?utf-8?B?MVVqNHNYRUxEZUtGS2llRElnT3lMQ1o1QkRYY3NOWUZ1UzYrckxzdWxUMmNI?=
 =?utf-8?B?TlcyTzkxTHM1YkE1TUdWaDVMV1RRaXFqK2pQL051WlcvbVRPL1hDMVRYMzlC?=
 =?utf-8?B?TGk0SFZSaGF3c3pkeVFvRERvbU51VDVOTktHUjBWWmMzamVaMXBkV0o1ZldU?=
 =?utf-8?B?SFN2cW9vdUQrZWErUlhWVWJBSlJjbkFFOEJYdStIbExDVEJNbDJHMXppVU05?=
 =?utf-8?B?SHdXY0k4d0NxMko2VVdReGYwZXUzelk2aHQ4b3dCdzZ5YStkOXg0VDd5Qy8x?=
 =?utf-8?B?N3ozUkNxNnFXTjE4bjhEdzVieUwwOEJsMzBoaG5UUGxJOUZJaE5UNXRpY0dp?=
 =?utf-8?B?dTJpMHNDa3Rid2JVb2pwUjNzZDhiQTBVbDNIaWhhSDAveVRENGVidUd0OGNt?=
 =?utf-8?B?UEVBVmhzYkpHRjIvNnRNUWl0a1hsSzdZdmRaVUFaM3MvL0p0V0pVSWEybE94?=
 =?utf-8?B?QW13V2FSME9DckhhNGZHM3lGVENsd25JUHZUSHBKaURMZ1U2MDRkYWdqZkRS?=
 =?utf-8?B?ZnVhaFBIZmxjNGVQc2NPY3RlVVFFQ0x3VmZTSFA3T3NXT0xhK3ZGbHJmdGt2?=
 =?utf-8?B?L1RjTDAxNUk2VkpMU1RSNU1lMzhYSzdQcm91VWFxaittV3ZFSFpZVmp2SmFm?=
 =?utf-8?B?VmNwT01ianJ1STBsK2NaaU9QQjhwNlZEa3dsTG9oN0VUQXluNTZ5TTU5MGM2?=
 =?utf-8?B?S3QxZ1hJZ3o3RmlHU0RrUmcvcmIxZng1NlZnOGFZajBOOE1jU3pCNFVhTWxa?=
 =?utf-8?B?OHNqY2dIY1BqWGxBdkRjUyszWWZEb1ZXbEprcVRTd2h5SDBLbXI5NjBkNllE?=
 =?utf-8?B?eWdQR1RYY2FFOXVEUGs1S0dIcThNcTNTa0sybGhtd3gxQUZocFBjU05PK051?=
 =?utf-8?B?eVE4UHhRQkNhd1FRR21CRHJIR0lIRThoczBIZGlzTzR5UmRzL1FCSzJVelhY?=
 =?utf-8?B?dXRYcmVaMzhlS1d4bXNrWEF5UmoxZjk2WUE3Y1dxUitydjBoUXBJaVdtU0FJ?=
 =?utf-8?B?UmNpVXFVL0hseXNYbXEzNmVFbjQrcW1ja1NOOEVCVmwzelRMbTI1Z0FwM0Ex?=
 =?utf-8?B?WVZaZkY3T0l1bmZSd25zZkRMTHZiT0IrRithY01FKy91WFhrME8zNG13N0ZO?=
 =?utf-8?B?TzdEdzdyaGwyTURkNmVXNXVqblRrdG5FWllnME5YSWl3dFM1b2VZN3g2dGho?=
 =?utf-8?B?aU9Kc2pkb0FHTFM0M3hxL01CUzRqc1NEQlNaeVFuRmxzOFgvdlRzaC9FYVo0?=
 =?utf-8?B?YXdKbFpoUDJ4L3VSZnYrck1lZGZLS0N5RzBnakhEWkRobkhWWG9qVkhnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR17MB2110.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZXdEdVpzc01ZVklLcDV6Rk5qSldjQmhSb3hCTWFnSE9PS1FuelRQanljS0dD?=
 =?utf-8?B?QTRtNjU2bVQveDdOYlBGZ3FiT00wSG5uS0hkbmFwWVpjczE0YWFKVDllcGZ4?=
 =?utf-8?B?TTNUeHBldHhha3NVbGhmTFlUdGRKai95L25KRGw3bzZzMkMxeWY1L1JaY1NW?=
 =?utf-8?B?eE14SCs3YnFjSkFWaXFiUTdROWh5S0pnaFJDdFQ0LzhZK25SRzRoaXBZS0Ni?=
 =?utf-8?B?ZGx0SndtMm1XQ0JsQTZCNHJVTzArbXBGY0Z4YzdRMUU0TGZrWnI4YnBjUDhR?=
 =?utf-8?B?UUorVUpsbzlvT0tPWWJMMlhITDNXSzY1R005cEl2bGtnRmRUVGVibnJqRWIv?=
 =?utf-8?B?L0pJdElPc1lMQzdQejZoS3VDeElDeXVsVGt1Q2ZhazJQUGk4UHBmZGF3WDRV?=
 =?utf-8?B?K3ZvUGdRMDBnMzIrZEFqVWt5MjBXaVk0U2ZyeFJJaTVFbW5iSGxLTU1ES3hq?=
 =?utf-8?B?VFNQYmRzcktiaVdzSlVrR3lrQ0Q0bU5nNzNsUUJiRGxPZEkzUWQ4ZFBDeGlJ?=
 =?utf-8?B?V09iaFZLQzA5MGF1ZUtLSzd1VmlWREgvSnZ1TlFzSXVLQTdSV0xzSUMyQUVi?=
 =?utf-8?B?RlpNdDNTRXdJRGcwVVFLem9PbndOY2pEZGFJZzlFSVd1WFBZTk4xVWYvN1M2?=
 =?utf-8?B?dERqRlkwS211QUVISlNnZ2YySVc0d29nVWNZZFVIV3QxRmhTSHhscVo3eU12?=
 =?utf-8?B?OEpOWjVLRC81SWNtL2tWS1NkUWttNzlqbEZJb3FsQmdXVi9kMU1EZG5HL0hE?=
 =?utf-8?B?WGI1eTRVTDY0cG9rMkpzbHU4NUxhaHU4Qzc1Q2VUcTJBNnBVZFFmb2FvZ0dx?=
 =?utf-8?B?VlJWODZMMDFBaEE5VjM4ZFlCeTQ0b0lOWjVSWm9lQ0xueWxSdEJwdHh3eFZo?=
 =?utf-8?B?Qyt4SFc3TVk4bnVURStYV3A3OE5zOW1mazVKRitGUnNac0JHbEVrSFVTV3RJ?=
 =?utf-8?B?dFJLT1RHYVE0QzUrUnR6V0tONlR5b21PZWNRSXNhNnI0L3Q4WkVxRCtJbWRr?=
 =?utf-8?B?dXVtTVV0N3F0S2pGOERjQSs2aXF0L1MvK0hSVG93KzJaRXFwUWJLZlB5Mlg5?=
 =?utf-8?B?VnhwSDFDWWZzWFpUMHM4MDR5YVhnUjBvai9XWTVZb3RiSVMvL1JLSld2bC9m?=
 =?utf-8?B?c203NnF1M1ZDTzhiVHVZTWlxNTNUdmZ6c3FsOEtQalFaUk1VdTlnMHFWZnJR?=
 =?utf-8?B?M01ock8rOWtVanB2V1NBVE14U1hSR1hPWTVueDExSUJqUWRhQmVEcElmVWxH?=
 =?utf-8?B?UmticVlFVDB5VlRNd0FBM2Q5a3JYQU9yZEFFajdFTlVOcFRBWkYvOFc0YjlD?=
 =?utf-8?B?elBSVWE1TWxuNzZOeHIyRXVEM2JFbExnUjZQSnk5TmcvR1N4L0VkZHFhdjNm?=
 =?utf-8?B?UU1sTnZVMERqeE5UbXA3RkxiUWQwUm5PS2tXb3hUV0lacTV5N2NmWmRsNE9B?=
 =?utf-8?B?Q0kwZzFKV2ZFeUd0M2RJNXpna0JNRm11SGhqNXlWOTlZd3U5QkU2MEQvcklk?=
 =?utf-8?B?SlFtV0RjVXAvUFFaNklrRmJFYTZZNE5tSy9XSU9MZmhjZ1pBQ2hOWTN1RnIx?=
 =?utf-8?B?U0xFc1RpalVvcTNyaGRZRUpxeElhcDVzV3dFR1Zma2ZMQ2laNXFFY0M1NkVk?=
 =?utf-8?B?Wkdtb0pDU0cvWTVaUjVTUlVYNmVLQ1pCZlNYeFBIdEJjaE5WTTNYSm9OR3k0?=
 =?utf-8?B?SUxLYTZqMUtEb3ZLeUtRTklGU2tnMldmcjR4SGN3cjgvbi9sOHNBamxrRjI1?=
 =?utf-8?B?QjR6clcwK2hyK3JIYUt4U3JSZGZnQ1g1UVBCeUlGZ1JHamx1cHBPRExRaXVw?=
 =?utf-8?B?YWlSRUV1NXg5MHR1bUc0WWZkQXUybVgzVEViWUpUL1RnV1JTQ2JLVCtDSmlh?=
 =?utf-8?B?d2pLRWNROFBCeHlITVpHTEZwd0czcEZ2eUNkd3FMQjRsbDltVlJleUU5MVJ0?=
 =?utf-8?B?K3dpajZ5eHd2SldiT0EwSGZ2c0RkNlp6Zmtub3piVkFVSUNRK2RXRGZsQ0Ft?=
 =?utf-8?B?c1FJTHNyekhReWhEb2hKTVVhdm9wQWZLbTljS3ZpZmJ3VTV5ZFF2K1cxZGc3?=
 =?utf-8?B?R0xXQWlGL3hyYzREMkNOeSs1UmJrVHhlVG5jaGpnc2k5RHhrZXBVZXJYRHdx?=
 =?utf-8?B?NmkwQ3VyTXpmVkJqUVloN09GemtvcHdUNGM0VWZFd25VV2N6SUdZRVdTbVh5?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ySUmYJ8CD+gQqBiAa7udttm2jNmHuAdim2RDIZkXVk4/k+7VGaOTanbkQHqb9GJJvXmuW6bVkFFeEUxgivP/+4iTtgu3akNTNKyuy8PzU6A1vTRoIewl1NvVSLh5BYt+VozFqdQvOtpAdM8NX0xXSBm+6JLSMxK6fVGpXzbEYWeY7q3Mb8re7XgZFHscKQNL/ZHinzIGYvBggX6jkx+N2Ctkruv7nYaaZQIoIORKOzsp/rVJWR29UC7BH2o+embloUk6bTCgVDjya37k5jDmBS0EB2lFpx09FxSBPrjhXdu1eG79zc0BUkRoKnk/9a1rtVoEcizEX8vZCUgSllariZbTPFAiI8uuhhrpTKC7ydx/3aGVWdOS7xkKeyEXhnSs35DFyABMuHt18Okc9rpheOogToJ5PVUkzfCjdkByH8KJwWHd9VGCy4sUcMknPDK7lUDWsMPwwwFH5/j0GU2EvkvZQ+1fqN3pT3D00Pe4Gt0gAL7aLthyjFC+w5xWvnPo18nxAdYQQtR35E8tiMGqEkRdIfHSfjnuYB9v6mm5e7VN+fxqSN3TG64WMJl4Hh3OCKopPK0TmeHR6wBiLTgvJ6ispBBmCMLOTQPLubNqLPgotLvH4x+6BkHKayT/JbnI
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR17MB2110.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bbc54f-e348-4cd4-7c73-08dc7ac17ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 00:44:25.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZjxZLFHeZPnbAAF3wTIC6nA3/mzOOSBTi1/HokyXoXQy9Gdm53sg0LJ3tpOLqTrv7gOzR0CI8kP6iZrCAmEvYt6gfJ0f+s2fVZ3/O9jPww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR17MB7278
X-Proofpoint-ORIG-GUID: xeCNO0oqTP1AU27Ttgrwuifl5uNunfO5
X-Proofpoint-GUID: xeCNO0oqTP1AU27Ttgrwuifl5uNunfO5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_14,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230003

QXBvbG9naWVzIGZvciByZXNlbmRpbmcgYXMgcGxhaW4gdGV4dCwgdGhlIGZpcnN0IHRyeSB3YXMg
SFRNTCBhbmQgZ290IHJlamVjdGVkIGJ5IGJvdHMuDQoNCj4gT24gV2VkLCBNYXkgMjIsIDIwMjQg
YXQgNjoxOeKAr1BNIEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+
DQo+ID4gSGkgSmFtYWwhDQo+ID4NCj4gPiBPbiBUdWUsIDIxIE1heSAyMDI0IDA4OjM1OjA3IC0w
NDAwIEphbWFsIEhhZGkgU2FsaW0gd3JvdGU6DQo+ID4gPiBBdCB0aGF0IHBvaW50KHYxNikgaSBh
c2tlZCBmb3IgdGhlIHNlcmllcyB0byBiZSBhcHBsaWVkIGRlc3BpdGUgdGhlDQo+ID4gPiBOYWNr
cyBiZWNhdXNlLCBmcmFua2x5LCB0aGUgTmFja3MgaGF2ZSBubyBtZXJpdC4gUGFvbG8gd2FzIG5v
dA0KPiA+ID4gY29tZm9ydGFibGUgYXBwbHlpbmcgcGF0Y2hlcyB3aXRoIE5hY2tzIGFuZCB0cmll
ZCB0byBtZWRpYXRlLiBJbiBoaXMNCj4gPiA+IG1lZGlhdGlvbiBlZmZvcnQgaGUgYXNrZWQgaWYg
d2UgY291bGQgcmVtb3ZlIGVCUEYgLSBhbmQgb3VyIGFuc3dlciB3YXMNCj4gPiA+IG5vIGJlY2F1
c2UgYWZ0ZXIgYWxsIHRoYXQgdGltZSB3ZSBoYXZlIGJlY29tZSBkZXBlbmRlbnQgb24gaXQgYW5k
DQo+ID4gPiBmcmFua2x5IHRoZXJlIHdhcyBubyB0ZWNobmljYWwgcmVhc29uIG5vdCB0byB1c2Ug
ZUJQRi4NCj4gPg0KPiA+IEknbSBub3QgZnVsbHkgY2xlYXIgb24gd2hvIHlvdSdyZSBhcHBlYWxp
bmcgdG8sIGFuZCBJIG1heSBiZSBtaXNzaW5nDQo+ID4gc29tZSBwb2ludHMuIEJ1dCBtYXliZSBp
dCB3aWxsIGJlIG1vcmUgdXNlZnVsIHRoYW4gaHVydGZ1bCBpZiBJIGNsYXJpZnkNCj4gPiBteSBw
b2ludCBvZiB2aWV3Lg0KPiA+DQo+ID4gQUZBSVUgQlBGIGZvbGtzIGRpc2FncmVlIHdpdGggdGhl
IHVzZSBvZiB0aGVpciBzdWJzeXN0ZW0sIGFuZCB0aGV5DQo+ID4gcG9pbnQgb3V0IHRoYXQgUDQg
cGlwZWxpbmVzIGNhbiBiZSBpbXBsZW1lbnRlZCB1c2luZyBCUEYgaW4gdGhlIGZpcnN0DQo+ID4g
cGxhY2UuDQo+ID4gVG8gd2hpY2ggeW91IHJlcGx5IHRoYXQgeW91IGxpa2UgKGEgaGlnaGx5IGRh
dGVkIHR5cGUgb2YpIGEgbmV0bGluaw0KPiA+IGludGVyZmFjZSwgYW5kIChoYW5kd2F2ZXkpIGFi
aWxpdHkgdG8gY29uZmlndXJlIHRoZSBkYXRhIHBhdGggU1cgb3INCj4gPiBIVyB2aWEgdGhlIHNh
bWUgaW50ZXJmYWNlLg0KPiANCj4gSXQncyBub3Qgd2hhdCBJICJsaWtlIiAsIHJhdGhlciBpdCBp
cyBhIHJlcXVpcmVtZW50IHRvIHN1cHBvcnQgYm90aA0KPiBzL3cgYW5kIGgvdyBvZmZsb2FkLiBU
aGUgVEMgbW9kZWwgaXMgdGhlIHRyYWRpdGlvbmFsIGFwcHJvYWNoIHRvDQo+IGRlcGxveSB0aGVz
ZSBtb2RlbHMuIEkgYWRkcmVzc2VkIHRoZSBzYW1lIGNvbW1lbnQgeW91IGFyZSBtYWtpbmcgYWJv
dmUNCj4gaW4gIzFhIGFuZCAjMWIgIChodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9naXRodWIuY29tL3A0dGMtZGV2L3B1c2hiYWNrLXBhdGNoZXNfXzshIUk1cFZrNExJR0FmbnZ3
IWthWjZFbVB4RXFHTEc4Sk13LV9MMEJnWXE0OFBlMjV3ajZwSE1GNkJWZWk1V3NSZ3dNZUxRdXBt
dmd2THlOLUxnWGFjS0J6enMwLXcyektQMkEkKS4NCj4gDQo+IE9UT0gsICJCUEYgZm9sa3MgZGlz
YWdyZWUgd2l0aCB0aGUgdXNlIG9mIHRoZWlyIHN1YnN5c3RlbSIgaXMgYQ0KPiBwcm9ibGVtYXRp
YyBzdGF0ZW1lbnQuIElzIEJQRiBpbmZyYSBmb3IgdGhlIGtlcm5lbCBjb21tdW5pdHkgb3IgaXMg
aXQNCj4gc29tZXRoaW5nIHRoZSBlYnBmIGZvbGtzIGNhbiBkZWNpZGUsIGF0IHRoZWlyIHdoaW0s
IHRvIGFsbG93IHdobyB0aGV5DQo+IGxpa2UgdG8gdXNlIG9yIG5vdC4gV2UgYXJlIG5vdCBjaGFu
Z2luZyBhbnkgQlBGIGNvZGUuIEFuZCB0aGVyZSdzDQo+IGFscmVhZHkgYSBjYXNlIHdoZXJlIHRo
ZSBpbnRlcmZhY2VzIGFyZSB1c2VkIGV4YWN0bHkgYXMgd2UgdXNlZCB0aGVtDQo+IGluIHRoZSBj
b25udHJhY2sgY29kZSBpIHBvaW50ZWQgdG8gaW4gdGhlIHBhZ2UgKHdlIGxpdGVyYWxseSBjb3Bp
ZWQNCj4gdGhhdCBjb2RlKS4gV2h5IGlzIGl0IG9rIGZvciBjb25udHJhY2sgY29kZSB0byB1c2Ug
ZXhhY3RseSB0aGUgc2FtZQ0KPiBhcHByb2FjaCBidXQgbm90IHVzPw0KPiANCj4gPiBBRkFJQ1Qg
dGhlcmUncyBzb21lIGJ1dCBub3QgdmVyeSBzdHJvbmcgc3VwcG9ydCBmb3IgUDRUQywNCj4gDQo+
IEkgZG9udCBhZ3JlZS4gUGFvbG8gYXNrZWQgdGhpcyBxdWVzdGlvbiBhbmQgYWZhaWsgSW50ZWws
IEFNRCAoYm90aA0KPiBidWlsZCBQNC1uYXRpdmUgTklDcykgYW5kIHRoZSBmb2xrcyBpbnRlcmVz
dGVkIGluIHRoZSBNUyBEQVNIIHByb2plY3QNCj4gcmVzcG9uZGVkIHNheWluZyB0aGV5IGFyZSBp
biBzdXBwb3J0LiBMb29rIGF0IHdobyBpcyBiZWluZyBDY2VkLiBBIGxvdA0KPiBvZiB0aGVzZSBm
b2xrcyB3aG8gYXR0ZW5kIGJpd2Vla2x5IGRpc2N1c3Npb24gY2FsbHMgb24gUDRUQy4gU2FtcGxl
Og0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bmV0ZGV2L0lBMFBSMTdNQjcwNzBCNTFBOTU1RkI4NTk1RkZCQTVGQjk2NUUyQElBMFBSMTdNQjcw
NzAubmFtcHJkMTcucHJvZC5vdXRsb29rLmNvbS9fXzshIUk1cFZrNExJR0FmbnZ3IWthWjZFbVB4
RXFHTEc4Sk13LV9MMEJnWXE0OFBlMjV3ajZwSE1GNkJWZWk1V3NSZ3dNZUxRdXBtdmd2THlOLUxn
WGFjS0J6enMwOVRGem9RQnckDQo+IA0KKzENCj4gPiBhbmQgaXQNCj4gPiBkb2Vzbid0IGJlbmVm
aXQgb3Igc29sdmUgYW55IHByb2JsZW1zIG9mIHRoZSBicm9hZGVyIG5ldHdvcmtpbmcgc3RhY2sN
Cj4gPiAoZS5nLiBleHByZXNzaW5nIG9yIGNvbmZpZ3VyaW5nIHBhcnNlciBncmFwaHMgaW4gZ2Vu
ZXJhbCkNCj4gPg0KPiANCg0KSHVoPyBBcyBhIERTTCwgUDQgaGFzIGFscmVhZHkgYmVlbiBwcm92
ZW4gdG8gYmUgYW4gZXh0cmVtZWx5IGVmZmVjdGl2ZSBhbmQgcG9wdWxhciB3YXkgdG8gZXhwcmVz
cyBwYXJzZSBncmFwaHMsIHN0YWNrIG1hbmlwdWxhdGlvbiwgYW5kIHN0YXRlZnVsIHByb2dyYW1t
aW5nLiBZZXN0ZXJkYXksIEkgdXNlZCB0aGUgUDRUQyBkZXYgYnJhbmNoIHRvIGltcGxlbWVudCBz
b21ldGhpbmcgaW4gb25lIHNpdHRpbmcsIHdoaWNoIGluY2x1ZGVzIHBhcnNpbmcgUm9DRXYyIG5l
dHdvcmsgc3RhY2tzLiBJIGp1c3QgY3V0IGFuZCBwYXN0ZWQgUDQgY29kZSBvcmlnaW5hbGx5IHdy
aXR0ZW4gZm9yIGEgUDQgQVNJQyBpbnRvIGEgd29ya2luZyBQNFRDIGV4YW1wbGUgdG8gYWRkIGZ1
bmN0aW9uYWxpdHkuIEl0IHRvb2sgbWVyZSBzZWNvbmRzIHRvIGNvbXBpbGUgYW5kIGxhdW5jaCBp
dCwgYW5kIGEgZmV3IG1pbnV0ZXMgdG8gdGVzdCBpdC4gSSBrbm93IG9mIG5vIG90aGVyIHdvcmtm
bG93IHdoaWNoIHByb3ZpZGVzIHN1Y2ggcXVpY2sgdHVybmFyb3VuZCBhbmQgaXMgc28gYWNjZXNz
aWJsZS4gSSdkIGxpa2UgaXQgdG8gYmUgYXMgdWJpcXVpdG91cyBhcyBlQlBGIGl0c2VsZi4NCg0K
PiBJIGFtIG5vdCBzdXJlIHdoZXJlIHRoZSBwYXJzZXIgdGhpbmcgY29tZXMgZnJvbSAtIHRoZSBw
YXJzZXIgaXMNCj4gZ2VuZXJhdGVkIGFzIGVCUEYuDQo+IA0KPiA+IFNvIGZyb20gbXkgcGVyc3Bl
Y3RpdmUsIHRoZSBzdWJtaXNzaW9uIGlzIG5laXRoZXIgdGVjaG5pY2FsbHkgc3Ryb25nDQo+ID4g
ZW5vdWdoLCBub3IgYnJvYWRseSB1c2VmdWwgZW5vdWdoIHRvIGNvbnNpZGVyIG1ha2luZyBxdWVz
dGlvbmFibGUgcHJlY2VkZW50cw0KPiA+IGZvciwgaS5lLiB0byBvdmVycmlkZSBtYWludGFpbmVy
cyBvbiBob3cgdGhlaXIgc3Vic3lzdGVtcyBhcmUgZXh0ZW5kZWQuDQpJIGRpc2FncmVlIHZlaGVt
ZW50bHkgb24gdGhlICJicm9hZGx5IHVzZWZ1bCBlbm91Z2giIGNvbW1lbnQuDQo+IA0KPiBJIGJl
bGlldmUgYXMgYSBjb21tdW5pdHkgbm9ib2R5IHNob3VsZCBqdXN0IGhhdmUgdGhlIHBvd2VyIHRv
IG5hY2sNCj4gdGhpbmdzIGp1c3QgYmVjYXVzZSAtIGFzIGkgc3RhdGVkIGluIHRoZSBwYWdlLCBu
b3QgZXZlbiBMaW51cy4gVGhhdA0KPiBjb2RlIGRvZXNudCB0b3VjaCBhbnl0aGluZyB0byBkbyB3
aXRoIGVCUEYgbWFpbnRhaW5lcnMgKG1lYW5pbmcgdGhpbmdzDQo+IHRoZXkgaGF2ZSB0byBmaXgg
d2hlbiBhbiBpc3N1ZSBzaG93cyB1cCkgbmVpdGhlciBkb2VzIGl0ICJleHRlbmQiIGFzDQo+IHlv
dSBzdGF0ZSBhbnkgZWJwZiBjb2RlIGFuZCBpdCBpcyBhbGwgcGFydCBvZiB0aGUgbmV0d29ya2lu
Zw0KPiBzdWJzeXN0ZW0uIFN1cmUsICBhbnlib2R5IGhhcyB0aGUgcmlnaHQgdG8gbmFjayBidXQg
IEkgY29udGVuZCB0aGF0DQo+IG5hY2tzIHNob3VsZCBiZSBiYXNlZCBvbiB0ZWNobmljYWwgcmVh
c29ucy4gSSBoYXZlIGxpc3RlZCBhbGwgdGhlDQo+IG9iamVjdGlvbnMgaW4gdGhhdCBwYWdlIGFu
ZCBob3cgaSBoYXZlIHJlc3BvbmRlZCB0byB0aGVtIG92ZXIgdGltZS4NCj4gU29tZW9uZSBuZWVk
cyB0byBsb29rIGF0IHRob3NlIG9iamVjdGl2ZWx5IGFuZCBzYXkgaWYgdGhleSBhcmUgdmFsaWQu
DQo+IFRoZSBhcmd1ZW1lbnQgbWFkZSBzbyBmYXIoQnkgUGFvbG8gYW5kIG5vdyBieSB5b3UpICBp
cyAid2UgY2FudA0KPiBvdmVycmlkZSBtYWludGFpbmVycyBvbiBob3cgdGhlaXIgc3Vic3lzdGVt
cyBhcmUgdXNlZCIgdGhlbiB3ZSBhcmUgaW4NCj4gdW5jaGFydGVkIHRlcnJpdG9yeSwgdGhhdHMg
d2h5IGkgYW0gYXNraW5nIGZvciBhcmJpdHJhdGlvbi4NCj4gDQo+IGNoZWVycywNCj4gamFtYWwg
DQpNYWludGFpbmVyczogSSBhbSBwZXJwbGV4ZWQgYW5kIGRpc21heWVkIHRoYXQgdGhpcyBpcyBn
ZXR0aW5nIHNvIG11Y2ggcHVzaGJhY2suIE5vbmUgb2YgdGhlIG9iamVjdGlvbnMsIHJlZ2FyZGxl
c3Mgb2YgdGhlaXIgbWVyaXRzIChvciBub3QpIHNlZW0gdG8gb3V0d2VpZ2ggdGhlIHBvdGVudGlh
bCBiZW5lZml0cyB0byBlbmQtdXNlcnMuIEkgYW0gZXh0cmVtZWx5IGludGVyZXN0ZWQgaW4gdXNp
bmcgUDRUQywgaXQgYWRkcyBhIGxvdCBvZiB2YWx1ZSBhbmQgcmV1c2VzIHNvIG11Y2ggZXhpc3Rp
bmcgTGludXggaW5mcmEuIFRoZSBjdXN0b20gZXh0ZXJuIG1vZGVsIGlzIGNvbXBlbGxpbmcuIFRo
ZSBjb250cm9sIHBsYW5lIENSVURYUFMgd2lsbCB0aWUgbmljZWx5IGludG8gUDRSdW50aW1lIGFu
ZCBUREkuIEkgaGF2ZSBhbiBhcHBsaWNhdGlvbiB3aGljaCBuZWVkcyB0byBydW4gcHVyZWx5IGlu
IFNXIC0gbm8gSFcgb2ZmbG9hZCwgc28gcHJpb3Igc3VnZ2VzdGlvbnMgdG8gd2FpdCBmb3IgaXQg
dG8gImFwcHJvdmUiIHRoaXMgaXMgZnJ1c3RyYXRpbmcuICBJIGNvdWxkIHVzZSB0aGlzIHllc3Rl
cmRheS4gRnVydGhlcm1vcmUsIGFzIGFuIGFjdGl2ZSBjb250cmlidXRvciB0byBzb25pYy1kYXNo
LCB3aGVyZSB3ZSBtb2RlbCB0aGUgcGlwZWxpbmUgaW4gUDQsIEkgY2FuIHN0YXRlIHRoYXQgUDRU
QyBjb3VsZCBiZSBhIGNvbXBlbGxpbmcgYWx0ZXJuYXRpdmUgdG8gYm12Miwgd2hpY2ggaXMgc2xv
dywgbG9uZyBpbiB0aGUgdG9vdGggYW5kIGxhY2tzIFBOQSBzdXBwb3J0Lg0KDQpJIGJlc2VlY2gg
dGhlIE5BQ0tlcnMgdG8gdGFrZSBhIGRlZXAgYnJlYXRoLCByZWV2YWx1YXRlIGFueSBlbnRyZW5j
aGVkIHBvc2l0aW9ucyBhbmQgY29uc2lkZXIgaG93IG11Y2ggZ29vZG5lc3MgdGhpcyB3aWxsIGFk
ZCwgZXZlbiBpZiB0aGlzIGlzIG5vdCB5b3VyIHByZWZlcmVuY2UgZm9yIGltcGxlbWVudGluZyBk
YXRhcGF0aHMuIEl0IGRvZXNuJ3QgaGF2ZSB0byBiZS4gVGhhdCBjYW4gYW5kIHNob3VsZCBiZSBk
ZWNpZGVkIGJ5IHRoZSBsYXJnZXIgY29tbXVuaXR5LiBUaGlzIGNvdWxkIG9wZW4gdGhlIGRvb3Ig
dG8gdGhvdXNhbmRzIG9mIGNyZWF0aXZlIGRldmVsb3BlcnMgd2hvIGFyZSBjb21mb3J0YWJsZSBp
biBQNCBidXQgbm90IGFkZXB0IGluIGxvdy1sZXZlbCBuZXR3b3JraW5nIGNvZGUuIFA0IGhhZCBh
IHNpZ25pZmljYW50IGltcGFjdCBvbiBkZW1vY3JhdGl6aW5nIG5ldHdvcmsgcHJvZ3JhbW1pbmcs
IGFuZCB0aGF0IHdhcyBqdXN0IG9uIGJtdjIgYW5kIFRvZmlubywgd2hpY2ggaXMgRU9MLiBNYWtp
bmcgcGVyZm9ybWFudCBhbmQgcG93ZXJmdWwgUDRUQyB1YmlxdWl0b3VzIG9uIHZpcnR1YWxseSBh
bnkgTGludXggc2VydmVyIGNvdWxkIGhhdmUgYSBzaW1pbGFyIGVmZmVjdCwganVzdCBsaWtlIGVC
UEYgb3BlbmVkIGEgbG90IG9mIGRvb3JzIHRvIG5vbi1rZXJuZWwgcHJvZ3JhbW1lcnMgdG8gZG8g
aW50ZXJlc3RpbmcgdGhpbmdzLiBCZSBhIHBhcnQgb2YgdGhhdCB0cmFuc2Zvcm1hdGlvbiENCg==

