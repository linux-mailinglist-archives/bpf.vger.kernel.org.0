Return-Path: <bpf+bounces-30804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8EB8D28CF
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9C81F21998
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 23:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CE13F446;
	Tue, 28 May 2024 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b="T2eAwUL6";
	dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b="Ef2xnjb1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-003cac01.pphosted.com (mx0a-003cac01.pphosted.com [205.220.161.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE7A22089;
	Tue, 28 May 2024 23:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.161.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716939829; cv=fail; b=a8ywlTzB6uZd/mUGlnVG/uAO/t/UPpixAw3zOG47TIBm2mUWQgefLhDWfNupHxy6263Cgy/XLhDZsOAm42O5NxJjPzpOhOLXIkOEnPLO8HOPSaE4BqvAgvr2smEUTngS1oztneV1lqOf0m2gsHRTAlvvy2YM8eo7QS2KKcV8k3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716939829; c=relaxed/simple;
	bh=4PObjbOr3kuXyg6XMcklNnAeEEy6FiWRHIpigJFjXAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HTvgdVA/eGMF3JE/T4Mted/dd+gavNJJfB9zwNYsR/22CVra46APFPDda/dXG01MCLSgsO4ivJR0hE5lXansWq7dvAsD0ciw6RRTLRBKvulVzWmBMVODtPzXKlU/7DjMrXTKURaeqRijhiq+GCNhsVx212tlk40qym1/iEtXYZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com; spf=pass smtp.mailfrom=keysight.com; dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b=T2eAwUL6; dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b=Ef2xnjb1; arc=fail smtp.client-ip=205.220.161.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=keysight.com
Received: from pps.filterd (m0187211.ppops.net [127.0.0.1])
	by mx0b-003cac01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SNhH4A012878;
	Tue, 28 May 2024 16:43:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=ppfeb2020;
 bh=4PObjbOr3kuXyg6XMcklNnAeEEy6FiWRHIpigJFjXAY=;
 b=T2eAwUL67Xn+s6oHskUkHrEOmkyIEw8PiNkhT7qby4uEc8OJMEGxRAJerR0Ayg0O20K7
 ZRjH0/KawvEAqw48iTC3UadmmAoiv8D3SaahdJhitRdXw0nhCSBdZAPcwrDDJj4WBCIh
 lww6qWEYOOYrmxseP+pdipTyCEA5uyC/xwJFtbad/+rjIeWw7nMRhMZZW4Q06Ots7Ogn
 pz86mdeWNEAgOgpPtREGtt1fEZ6t6dRG6LfNCwoqyj6DOM3pZC3IQsK6KE2eQzOhGzsi
 fFu2OM2vSUfYrE2fIuM1cvi1AnEG1seInEn6CCw4tUUu3EReG9tGa0mqOEiDzOEztCZu 6g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 3ydhtr8ud7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 16:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8fOw/SCImhWUqTtImZWEzz+RjhP4PO5jzABklStSnMxpkXJqGRYIxuKmzWyeaKXgs19qdFJ2/0syyN/NvnOD2Lutbo9TlDWwAmIS/Hirye80UK9ac8JVYOJ6JcuAews/th6RO5wICZ4wYQvhzrW3d437xCg6tHmQwNm7sgKMavMobrmEXLR4m2Gx+nwpCFKQwVHvPgLVPDBg0noNtOKXB+oAImWCfjlyct7oEcwzFxCAZGpI1Zsix7RDYLPlgrOrQwn6nBRh8p9p34US3Vrfdsr9xYizoDY4tzH5po2zrY9dF8201G9NKD6uvttnNuMBRrj7pGcV4Ov2QLohxSRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PObjbOr3kuXyg6XMcklNnAeEEy6FiWRHIpigJFjXAY=;
 b=PcqSiu+oGQe/+5P+BftQKxFxcDcCWsOMFYye1wcX8+Y0YUM3EikqDoEg+j9vFfW9PPE0RDLgARjrChef9aZjBlHY7CQqWPZ0GjxVSQ1HkH9gVco75oMQZz67P3+8L3UKf3HodoSShfheyKtslmdeXf5zWYtrPmzOWBRkWUrsujTm3CRjV5os15TAyp3RdbR8peAalrOp9YcRzZrAP8q3xi3/EZVsRqsIVhIHnG6ZhI5b01HFdO4luQMEbO/DLW1XLGSDICY0cB+yoGDbqNOOGjPfbvsy0l+0lKI80YW3mE6pBk/es7IUuvz2ggcDi6vi0FMrx7i36Qzj6M5+Cp9Cuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PObjbOr3kuXyg6XMcklNnAeEEy6FiWRHIpigJFjXAY=;
 b=Ef2xnjb1l1xmipCtThKt3uvqDZ/6VTrlQz2OwHIOLocHnEZuI58WuC6QLFlLC86uW1cul5IoCcxGV/tIDH6vOOKEaGa6wyIL9r0ME4+7hNM1RpP6nNbt6mYGaSdhXmjLVx7kZT+fCLvNIgBtPE62ja63TQxthE85Fz/k97xlMGU=
Received: from SN6PR17MB2110.namprd17.prod.outlook.com (2603:10b6:805:4e::33)
 by PH0PR17MB5486.namprd17.prod.outlook.com (2603:10b6:510:b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 28 May
 2024 23:43:13 +0000
Received: from SN6PR17MB2110.namprd17.prod.outlook.com
 ([fe80::897f:512f:1cc5:c1c2]) by SN6PR17MB2110.namprd17.prod.outlook.com
 ([fe80::897f:512f:1cc5:c1c2%5]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 23:43:12 +0000
From: Chris Sommers <chris.sommers@keysight.com>
To: Tom Herbert <tom@sipanda.io>, "Singhai, Anjali" <anjali.singhai@intel.com>
CC: John Fastabend <john.fastabend@gmail.com>,
        "Jain, Vipin"
	<Vipin.Jain@amd.com>,
        "Hadi Salim, Jamal" <jhs@mojatatu.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov
	<alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        "Chatterjee, Deb" <deb.chatterjee@intel.com>,
        "Limaye, Namrata"
	<namrata.limaye@intel.com>,
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
        "Tammela, Pedro" <pctammela@mojatatu.com>,
        "Daly, Dan" <dan.daly@intel.com>,
        Andy Fingerhut <andy.fingerhut@gmail.com>,
        Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>,
        "lwn@lwn.net"
	<lwn@lwn.net>
Subject: RE: On the NACKs on P4TC patches
Thread-Topic: On the NACKs on P4TC patches
Thread-Index: 
 AQHaq3taEWM9VDh9Vkmz6Q1EN+6MvbGj1UeAgAAMQQCAABa4EIAC81gAgAFCvgCABPK/AIAABTIwgAAowgCAAAFNQA==
Date: Tue, 28 May 2024 23:43:12 +0000
Message-ID: 
 <SN6PR17MB211087D7BF4ABCE2A8E4FA3D96F12@SN6PR17MB2110.namprd17.prod.outlook.com>
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
 <CO1PR11MB499350FC06A5B87E4C770CCE93F42@CO1PR11MB4993.namprd11.prod.outlook.com>
 <MW4PR12MB71927C9E4B94871B45F845DF97F52@MW4PR12MB7192.namprd12.prod.outlook.com>
 <MW4PR12MB719209644426A0F5AE18D2E897F62@MW4PR12MB7192.namprd12.prod.outlook.com>
 <66563bc85f5d0_2f7f2087@john.notmuch>
 <CO1PR11MB49932999F5467416D4F7197693F12@CO1PR11MB4993.namprd11.prod.outlook.com>
 <CAOuuhY8wMG0+WvYx3RC++pebcRF4aW1zAW+vgAb3ap-8Q-139w@mail.gmail.com>
In-Reply-To: 
 <CAOuuhY8wMG0+WvYx3RC++pebcRF4aW1zAW+vgAb3ap-8Q-139w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR17MB2110:EE_|PH0PR17MB5486:EE_
x-ms-office365-filtering-correlation-id: 840a6387-a967-4b4e-a92e-08dc7f6ff02c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RlNUNHFCN0tITTd2Qy8ramdsS0U5YXZzUWk3K2lJamg2ZWtiZExzeDR5dEl3?=
 =?utf-8?B?RGdsbmNGUUNGZUlkWEx5OGpLNTVtMFJSVFk1Rk9WWGhzOEwwYyt1ZGRwWm4r?=
 =?utf-8?B?dzNXSDI4OFhYbU1rUVQyOEZmb1dxdGJPclBDR1loUVpzOGFBMjJqRHEwRkND?=
 =?utf-8?B?amkxRjJGU084NWpFVlFHZDB2R2RxblJNNVBvS3FyZTNGWm5SUXloV1p2MDNp?=
 =?utf-8?B?c3ZzTThOOXAza2NjODh1aGFCczNKb2Erb2tKRFY0dGRPUXRoZTRNdkVtVkps?=
 =?utf-8?B?cllqVkxTeUJSTlNyU09xYjhtMlFVZDIwYkhaemFDa1ZpbmxpKzVXNitid0Rx?=
 =?utf-8?B?VFdXQ3JiVFhMSitxcFIrNWgyZGFDVHFveFpPelEyZmd6R2xBZGdlL0QwZmI2?=
 =?utf-8?B?TEk3YnByaDdGSFR0WGlJZ1BXakVmUU53ZHYvZHpYMENuTjVIcGVjckJ2cmhy?=
 =?utf-8?B?N3krNlg1bldoZ2krNjJuSTh5UXAzREh2V3NlK3cyYVFyclpBRGdwWUdlcXJD?=
 =?utf-8?B?TnNzeXpUS3d2dDBYbmI0eUZ0NFZ1em5veVEzbzFhcUlRUS8vMzk2ODVsVyts?=
 =?utf-8?B?MlpaWHlQeWFuWVErL0VrbWpzNnFtNmV1Kys4OVZKQ1lBWXpHbUpRMmxWV0pG?=
 =?utf-8?B?VjBlc0NrZ0o3MlVTZVdmK2k3T2VCWWJHay91OCtpZWx6OUhtZ3ZsWWR4UmZJ?=
 =?utf-8?B?c0E4eXozUlhCOWxTTmNWdjFsUzl5UTN0enc1aVVtSmI1akl0Q2wwM0I2dDlY?=
 =?utf-8?B?OUFrZ1JoYTFaNnYycHE2cmFteWdJeXNwMHF0N2d1RWJGS0IwNWxrUGJiSG1J?=
 =?utf-8?B?SVJyNU9ET2QrQSs0MjNLRHJHVGNsQkVPcWZkSzdkK0ZoRGNSUThDSDdMSmgx?=
 =?utf-8?B?VndHRFBoTEVmWmV1S3I5dm9NSzFmVzVFQmRmRmFQdVAzNzBBc3F0NFZTUXUx?=
 =?utf-8?B?QjZQNmFhanRSQ29SMWM5RlJoSUxxRDFWVnNXMENqbHNDT0IrTU1hSjc0bDRa?=
 =?utf-8?B?Qlh1RGpTNXFPMkhwQjVHb2QralpFOTU5aHVjNHgwYVBYYlVGVFBOSDJtdjI4?=
 =?utf-8?B?R3lMZ2ZyTGJITHROMVZwbVlrcXVCc2JPK1JaT0JmcFhkdlI1TFkzS3BoNkJy?=
 =?utf-8?B?cXFxaEJWRHUzMjVkS0ZZYnR0aWJSVnErNGRZeHVqalV4VlRyL0d4OVBycVUz?=
 =?utf-8?B?WThQUmZmSG1EY3dackhBb2lqZVNEc3Byd1RtamxtTVU5UlFoam5LM3ZaYk5F?=
 =?utf-8?B?OWdBc1oxQWVxSTZtMU9zY0xkVE96NU1kNy9EVWdpcU9RUVUySzhhU0Z1ZDRF?=
 =?utf-8?B?VXFCV0hObDZybkpCNS9SWnlHUEIzWFE1M0pWaVNqWVYzc2JpSXYrRWFFWmtm?=
 =?utf-8?B?ako0dmExMzlKM1Ztd0RCbURkb2haQjRFc3hNY1VXUllLUnQ0WTZtQ2pBaVFL?=
 =?utf-8?B?OFFRYjlkZGhGZW9WbGtMcTZuNUh1aFoya01MakRDMHFhUzgySzVnNXBnUEhB?=
 =?utf-8?B?aXIvV05xRjk3SVozdmdzd3lrVXQwWEtOT0xmVzFWM2IyeHNFa3owSm4rTWV4?=
 =?utf-8?B?aTZUTi9LZnpMMTlEeTlCam9veWtxTll1UzhuM05UVUZvTXZUS20yRUR2d1pM?=
 =?utf-8?B?ZDVrdERyc1cwUDRTK2hUSk52RzI0RnAraHhkdXpDWUpGeVdSbnVaVGVBZGVC?=
 =?utf-8?B?bkZMYjVhQ01iQ3c5RWpmUFI0cGl2K2YxdTNTdWxnT1o2L1R4Q3o0eW13PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR17MB2110.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VVdtTVZZUHpGdkZLcXEyaEg5RTR2dDRIYmJjV1NWbDR3dVB6Vi9qTjJaTnls?=
 =?utf-8?B?WDlHazZuSEZSejhqYy90bnJIRlN0ZE9KTjZaR0wwYncvd2duYWdwL2w2dFZy?=
 =?utf-8?B?UFBLVzRRTGh4c0c3aU41Z29jRTZZOEM5SVl0dHFrLzQxTFBZeE82UERJajQ0?=
 =?utf-8?B?eWJYUVozR0tTOTB0NGUwT3BkUkRqRTU0anhyU01RZUxWNndHNFlRZllTWUM0?=
 =?utf-8?B?aUR0UkQ3aDM3ZVpUMXVPTTBtQ2g0NDFDRkZLbWR3bHZXbUJocFhFM0dmNDhi?=
 =?utf-8?B?YTh3ZVNpem5scjVmM0RTK21vakxyMWpLSGZpMExJaENxSlNXOGY5Q1hZZWNu?=
 =?utf-8?B?eE13VmpnMDB6MmZXandBMnNSVGpMcVFvZFNqTlhpZzZPS3BJWmR6b0EwNm90?=
 =?utf-8?B?YkFXNlgyMUxFeE93bjlCMVVVYU1LZkVJSGxyb3FiVytucGozZjRDMzl5bWZs?=
 =?utf-8?B?eUU2YWZZSFluMjNOMjVkVVVwOHJUS0kyeVBtSXJWSW1FSi9CWEFxSlBPYUJH?=
 =?utf-8?B?cFJ3bllJT20yMGVwZUJ6Tzl3MDRRSGUxUlMzTmc2UmlhYjVIcUVBaW12UGUy?=
 =?utf-8?B?bGZDVkdBN2JSKzB5Q2FRa2oyZUdYWmwvTktrWHlhd1ErMHRwdExTMXpvRnQ5?=
 =?utf-8?B?VVdKaHhvOGJ0Z0FYNW9hRTV0RDV0ckd5NEQ4VlVDbzZmREtBWW80RUorczBV?=
 =?utf-8?B?UHN0NFRtQWtmV0dkQllhTFRoKy9RZTBqNCtlVzExaUNwRmhuWEtUd0RScWpk?=
 =?utf-8?B?Z1l6dm44S09uRVNjQ1VEdFQ0aVZONFJtb2RBbXpMTk1TQWppZWFzQjBOY2d6?=
 =?utf-8?B?aml1MkFPaURWSU9KclRoMkJncndOMWM2UVRqaUl3Vm5FWUc3U0RjS2RNSGx3?=
 =?utf-8?B?Uzl4eTNFN3JhdUdjTmpjSE01V3Jrb2l5MlBQRUQxYkx5U1d6eFNOM1crUXVH?=
 =?utf-8?B?d3VUZFNnQ2Iwd00rT0txZUhTVW95MEVCMHpVOUNxczhkK1kySmUrdjl2SnNV?=
 =?utf-8?B?cklVbkhObnpmUjNxYjZCK01ldFJEL2hUVjZ4OGlLVEVFLzFKMDR3Vk1TMXc4?=
 =?utf-8?B?NS9kTGlmMnBVR2ZPZGRPVjhURy92b1htODlMUEs5a0NUR1dleVBtUzBkVEdK?=
 =?utf-8?B?bHlOVHROOVI2ZHUwMnNZNnhXWnk1YzMzdWp0MkQvN1cyUmlLVG5zMzZxRTg0?=
 =?utf-8?B?aFdXNm5abTdUbDJzcEkvV2xwYU41MTlrRlh1djRWU2lDVXlTK1VpY0lPdlIw?=
 =?utf-8?B?SVI1b2hTM1dzYXdGZFFYNmc0dDZkYmt6UzN6RW03dU03T2lyNzdYaHdXcmhP?=
 =?utf-8?B?SWZrK05GV09JYnhOczMyOVdFQ2FZVUlCcU0wM2xiQTI2b3ZZNUJoUmY5ZVdr?=
 =?utf-8?B?STdqUzBLUnJLSjdGb3hPRURicVQ4SzRaa2Y4U3h4TitkZFhUU0dTSktLUzhP?=
 =?utf-8?B?eWM1ci84bUFsZUhBZ3ptNzVicTlUNmlYVzJ3N1RDb0NqWXl0NElkSlJTb3Rq?=
 =?utf-8?B?OXhsZjZrMnZUc0RLTTJkdWJkTVNXa0RrTkRLSVBCRUZod0FoSnZGQmRSdlQv?=
 =?utf-8?B?SFBaZXZpWXBPNUI1SFNKTCtrNzFsSU42TjVRdlFOdjkvSXBpVVhWazVsNlZE?=
 =?utf-8?B?VG04WUxLNTdHK3dGMjd1MlJ4KytKTVNVS1FZVit4K0RTZEk2aFJaaDFrbUg1?=
 =?utf-8?B?WTZYbkZCUFlwZEp5SHFrSHZVakxNVzhQcW1oVkoxU2pLd2pQcG14NWpmUXZD?=
 =?utf-8?B?RUgrWm1taVJLd3h5SDZzZGRMNFpHaythK2tQdUFQVi93SVNzellrWWxwNGEz?=
 =?utf-8?B?ZnhkTmJkb1lKTlRZT2Nkc08zNTIxMXpLUlNNTUNLMm9Cck80WDVobmlmRm5z?=
 =?utf-8?B?NnE1cEppM1lJL3pDQlJ5UnpvRnJVd05oUjh0Q1BvckJRSW0xR2NsZ2tRMnEz?=
 =?utf-8?B?UXJhblBrQjhFYXFwWVFBbnduYjF1Rm9VazdQMnRRTEQ1b3dLMUdRdUNoY20v?=
 =?utf-8?B?YXZVWXJZdmZQQjM2enRsM2JETEYzQjRKdytRTWVQUGErV2doN1B0RVRlaVNn?=
 =?utf-8?B?ZlhnYk0wMFZyK0s4MDdCcWN0VDIwZjFXVytvajlKaEJPRGJBQmZPNHRva3Jo?=
 =?utf-8?Q?N1Tmb9xq+7EchMkqHsdA+DUGf?=
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
	svL6kZFv4WDL/zk3pxiMEY5rk0Br0/GWDTp+pQ8q8VU7uv/vWJFvSXtnIlOjXeQGDq9f0i5oKuuCR2XAj3MFM9PdMipD7aPKDBSKxmv4MaqfTLt3foRudXxsT8lngpjnxv/trblcxHzl/dKtnLpuzaSAl0PnXEc2qiK8zuclKnRsUrqwJtzRyOl0cxkNqnM3APBmQNA1yNI7LynVxYXedJIF0ZMwzESsO4ZEJy8CY64u4rv+1Pw7RsZ1dugd9qpRPrLdSkUreTWROPH4wdPdw0Ma24ojchIpQgKSgkwvVws7SzhMUAabNWjgx411cgSWfDuD9yZJCliQMwemSMQzvarDW7IEWTgkoG/2edGLTxpoNSOjNh4ypLNeOKOAJH7X3x8+EebYxCt2seBEBYNOtTNCl6y0i1ejauLslnVKau9wAi/4m29aVP8vZ736OxDNlZH0/3DpjxHe4Fdn7qjyHONg41GeIEjhoIg0JLJ1cDnlJYy4MsSL/rQugzRSEMCGxN4jsd18wAF4Xw/rszH+x6rtvZlRxqiIHkgl4f6D2vh9vafRnKiEUfHAcpIel6ICbi5pFpQfBk16b5fnyi2R1+6I5i+CIPmsW6pGGzx5gRmvZhpErgoYqx+Cnv7aoAb6
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR17MB2110.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840a6387-a967-4b4e-a92e-08dc7f6ff02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 23:43:12.6935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijUBL6oYRTnhckWgtkPKfSw1es4xU0SpQeCvaNbICJmxjqlokuMlobD51GyUldeDlohTh5PMfCZPEluUhopZBciTjBwspKuGCWMGU7Q0y3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5486
X-Proofpoint-ORIG-GUID: af-GNqRuuGbBGAIQWqZfJTx_a-YvSgQ7
X-Proofpoint-GUID: af-GNqRuuGbBGAIQWqZfJTx_a-YvSgQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280175

PiBPbiBUdWUsIE1heSAyOCwgMjAyNCBhdCAzOjE34oCvUE0gU2luZ2hhaSwgQW5qYWxpDQo+IDxh
bmphbGkuc2luZ2hhaUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPkZyb206IEpvaG4gRmFz
dGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+DQo+ID4gPlNlbnQ6IFR1ZXNkYXksIE1h
eSAyOCwgMjAyNCAxOjE3IFBNDQo+ID4NCj4gPiA+SmFpbiwgVmlwaW4gd3JvdGU6DQo+ID4gPj4g
W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cj4gPiA+Pg0KPiA+ID4+IE15IGFwb2xvZ2llcywgZWFybGllciBlbWFpbCB1c2VkIGh0bWwgYW5k
IHdhcyBibG9ja2VkIGJ5IHRoZSBsaXN0Li4uDQo+ID4gPj4gTXkgcmVzcG9uc2UgYXQgdGhlIGJv
dHRvbSBhcyAiVko+Ig0KPiA+ID4+DQo+ID4gPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiA+DQo+ID4gPkFuamFsaSBhbmQgVmlwaW4gaXMgeW91ciBzdXBwb3J0
IGZvciBIVyBzdXBwb3J0IG9mIFA0IG9yIGEgTGludXggU1cgaW1wbGVtZW50YXRpb24gb2YgUDQu
IElmIGl0cyBmb3IgSFcgc3VwcG9ydCB3aGF0IGRyaXZlcnMgd291bGQgd2Ugd2FudCB0byBzdXBw
b3J0PyBDYW4geW91IGRlc2NyaWJlIGhvdyB0byBwcm9ncmFtID50aGVzZSBkZXZpY2VzPw0KPiA+
DQo+ID4gPkF0IHRoZSBtb21lbnQgdGhlcmUgaGFzbid0IGJlZW4gYW55IG1vdmVtZW50IG9uIExp
bnV4IGhhcmR3YXJlIFA0IHN1cHBvcnQgc2lkZSBhcyBmYXIgYXMgSSBjYW4gdGVsbC4gWWVzIHRo
ZXJlIGFyZSBzb21lIFNES3MgYW5kIGJ1aWxkIGtpdHMgZmxvYXRpbmcgYXJvdW5kIGZvciBGUEdB
cy4gRm9yIGV4YW1wbGUgPm1heWJlIHN0YXJ0IHdpdGggd2hhdCBkcml2ZXJzIGluIGtlcm5lbCB0
cmVlIHJ1biB0aGUgRFBVcyB0aGF0IGhhdmUgdGhpcyBzdXBwb3J0PyBJIHRoaW5rIHRoaXMgd291
bGQgYmUgYSBwcm9kdWN0aXZlIGRpcmVjdGlvbiB0byBnbyBpZiB3ZSBpbiBmYWN0IGhhdmUgaGFy
ZHdhcmUgc3VwcG9ydCBpbiB0aGUgd29ya3MuDQo+ID4NCj4gPiA+SWYgeW91IHdhbnQgYSBTVyBp
bXBsZW1lbnRhdGlvbiBpbiBMaW51eCBteSBvcGluaW9uIGlzIHN0aWxsIHB1c2hpbmcgYSBEU0wg
aW50byB0aGUga2VybmVsIGRhdGFwYXRoIHZpYSBxZGlzYy90YyBpcyB0aGUgd3JvbmcgZGlyZWN0
aW9uLiBNYXBwaW5nIFA0IG9udG8gaGFyZHdhcmUgYmxvY2tzIGlzIGZ1bmRhbWVudGFsbHkgPmRp
ZmZlcmVudCBhcmNoaXRlY3R1cmUgZnJvbSBtYXBwaW5nDQo+ID4gPlA0IG9udG8gZ2VuZXJhbCBw
dXJwb3NlIENQVSBhbmQgcmVnaXN0ZXJzLiBNeSBvcGluaW9uIC0tIHRvIGhhbmRsZSB0aGlzIHlv
dSBuZWVkIGEgcGVyIGFyY2hpdGVjdHVyZSBiYWNrZW5kL0pJVCB0byBjb21waWxlIHRoZSBQNCB0
byBuYXRpdmUgaW5zdHJ1Y3Rpb25zLg0KPiA+ID5UaGlzIHdpbGwgZ2l2ZSB5b3UgdGhlIG1vc3Qg
ZmxleGliaWxpdHkgdG8gZGVmaW5lIG5ldyBjb25zdHJ1Y3RzLCBiZXN0IHBlcmZvcm1hbmNlLCBh
bmQgbG93ZXN0IG92ZXJoZWFkIHJ1bnRpbWUuIFdlIGhhdmUgYSBQNCBCUEYgYmFja2VuZCBhbHJl
YWR5IGFuZCBKSVRzIGZvciBtb3N0IGFyY2hpdGVjdHVyZXMgSSBkb24ndCA+c2VlIHRoZSBuZWVk
IGZvciBQNFRDIGluIHRoaXMgY29udGV4dC4NCj4gPg0KPiA+ID5JZiB0aGUgZW5kIGdvYWwgaXMg
YSBoYXJkd2FyZSBvZmZsb2FkIGNvbnRyb2wgcGxhbmUgSSdtIHNrZXB0aWNhbCB3ZSBldmVuIG5l
ZWQgc29tZXRoaW5nIHNwZWNpZmljIGp1c3QgZm9yIFNXIGRhdGFwYXRoLiBJIHdvdWxkIHByb3Bv
c2UgYSBkZXZsaW5rIG9yIG5ldyBpbmZyYSB0byBwcm9ncmFtIHRoZSBkZXZpY2UgZGlyZWN0bHkg
PnZzIG92ZXJoZWFkIGFuZCBjb21wbGV4aXR5IG9mIGFic3RyYWN0aW5nIHRocm91Z2ggJ3RjJy4g
SWYgeW91IHdhbnQgdG8gZW11bGF0ZSB5b3VyIGRldmljZSB1c2UgQlBGIG9yIHVzZXIgc3BhY2Ug
ZGF0YXBhdGguDQo+ID4NCj4gPiA+LkpvaG4NCj4gPg0KPiA+DQo+ID4gSm9obiwNCj4gPiBMZXQg
bWUgc3RhcnQgYnkgc2F5aW5nIHByb2R1Y3Rpb24gaGFyZHdhcmUgZXhpc3RzIGkgdGhpbmsgSmFt
YWwgcG9zdGVkIHNvbWUgbGlua3MgYnV0IGkgY2FuIHBvaW50IHlvdSB0byBvdXIgaGFyZHdhcmUu
DQo+ID4gVGhlIGhhcmR3YXJlIGRldmljZXMgdW5kZXIgZGlzY3Vzc2lvbiBhcmUgY2FwYWJsZSBv
ZiBiZWluZyBhYnN0cmFjdGVkIHVzaW5nIHRoZSBQNCBtYXRjaC1hY3Rpb24gcGFyYWRpZ20gc28g
dGhhdCdzIHdoeSB3ZSBjaG9zZSBUQy4NCj4gPiBUaGVzZSBkZXZpY2VzIGFyZSBwcm9ncmFtbWVk
IHVzaW5nIHRoZSBUQy9uZXRsaW5rIGludGVyZmFjZSBpLmUgdGhlIHN0YW5kYXJkIFRDIGNvbnRy
b2wtZHJpdmVyIG9wcyBhcHBseS4gV2hpbGUgaXQgaXMgY2xlYXIgdG8gdXMgdGhhdCB0aGUgUDRU
QyBhYnN0cmFjdGlvbiBzdWZmaWNlcywgd2UgYXJlIGN1cnJlbnRseSBkaXNjdXNzaW5nIGRldGFp
bHMgdGhhdCB3aWxsIGNhdGVyIGZvciBhbGwgdmVuZG9ycyBpbiBvdXIgYml3ZWVrbHkgbWVldGlu
Z3MuDQo+ID4gT25lIGJpZyByZXF1aXJlbWVudCBpcyB3ZSB3YW50IHRvIGF2b2lkIHRoZSBmbG93
ZXIgdHJhcCAtIHdlIGRvbnQgd2FudCB0byBiZSBjaGFuZ2luZyBrZXJuZWwvdXNlci9kcml2ZXIg
Y29kZSBldmVyeSB0aW1lIHdlIGFkZCBuZXcgZGF0YXBhdGhzLg0KPiA+IFdlIGZlZWwgUDRUQyBh
cHByb2FjaCBpcyB0aGUgcGF0aCB0byBhZGQgTGludXgga2VybmVsIHN1cHBvcnQuDQo+ID4NCj4g
PiBUaGUgcy93IHBhdGggaXMgbmVlZGVkIGFzIHdlbGwgZm9yIHNldmVyYWwgcmVhc29ucy4NCj4g
PiBXZSBuZWVkIHRoZSBzYW1lIFA0IHByb2dyYW0gdG8gcnVuIGVpdGhlciBpbiBzb2Z0d2FyZSBv
ciBoYXJkd2FyZSBvciBpbiBib3RoIHVzaW5nIHNraXBfc3cvc2tpcF9ody4gSXQgY291bGQgYmUg
ZWl0aGVyIGluIHNwbGl0IG1vZGUgb3IgYXMgYW4gZXhjZXB0aW9uIHBhdGggYXMgaXQgaXMgZG9u
ZSB0b2RheSBpbiBmbG93ZXIgb3IgdTMyLiBBbHNvIGl0IGlzIGNvbW1vbiBub3cgaW4gdGhlIFA0
IGNvbW11bml0eSB0aGF0IHBlb3BsZSBkZWZpbmUgdGhlaXIgZGF0YXBhdGggdXNpbmcgdGhlaXIg
cHJvZ3JhbSBhbmQgd2lsbCB3cml0ZSBhIGNvbnRyb2wgYXBwbGljYXRpb24gdGhhdCB3b3JrcyBm
b3IgYm90aCBoYXJkd2FyZSBhbmQgc29mdHdhcmUgZGF0YXBhdGhzLiBUaGV5IGNvdWxkIGJlIHVz
aW5nIHRoZSBzb2Z0d2FyZSBkYXRhcGF0aCBmb3IgdGVzdGluZyBhcyB5b3Ugc2FpZCBidXQgYWxz
byBmb3IgdGhlIHNwbGl0L2V4Y2VwdGlvbiBwYXRoLiBDaHJpcyBjYW4gcHJvYmFibHkgYWRkIG1v
cmUgY29tbWVudHMgb24gdGhlIHNvZnR3YXJlIGRhdGFwYXRoLg0KDQpBbmphbGksIHRoYW5rcyBm
b3IgYXNraW5nLiBBZ3JlZWQsIEkgbGlrZSB0aGUgZmxleGliaWxpdHkgb2YgYWNjb21tb2RhdGlu
ZyBhIHZhcmlldHkgb2YgcGxhdGZvcm1zIGRlcGVuZGluZyB1cG9uIHBlcmZvcm1hbmNlIHJlcXVp
cmVtZW50cyBhbmQgaW50ZW5kZWQgdGFyZ2V0IHN5c3RlbS4gRm9yIG1lLCBmbGV4aWJpbGl0eSBp
cyBpbXBvcnRhbnQuIFNvbWUgc29sdXRpb25zIG5lZWQgYW4gaW5saW5lIGZpbHRlciBhbmQgUDQt
VEMgbWFrZXMgaXQgc28gZWFzeS4gVGhlIGZhY3QgSSB3aWxsIGJlIGFibGUgdG8gZ2V0IEhXIG9m
ZmxvYWQgbWVhbnMgSSdtIG5vdCBwZXJmb3JtYW5jZSBib3VuZC4gU29tZSBvdGhlciBzb2x1dGlv
bnMgbWlnaHQgbmVlZCBEUERLIGltcGxlbWVudGF0aW9uLCBzbyBQNC1EUERLIGlzIGEgY2hvaWNl
IHRoZXJlIGFzIHdlbGwsIGFuZCB0aGVyZSBhcmUgYWNjZWxlcmF0aW9uIG9wdGlvbnMuIEtlZXBp
bmcgbXVjaCBvZiB0aGUgZGF0YXBsYW5lIGRlc2lnbiBpbiBvbmUgbGFuZ3VhZ2UgKFA0KSBtYWtl
cyBpdCBlYXNpZXIgZm9yIG1vcmUgZGV2ZWxvcGVycyB0byBjcmVhdGUgcHJvZHVjdHMgd2l0aG91
dCBoYXZpbmcgdG8gYmUgcGxhdGZvcm0tbGV2ZWwgZXhwZXJ0cy4gQXMgc29tZW9uZSB3aG8ncyB3
b3JrZWQgd2l0aCBQNCBUb2Zpbm8sIFA0LVRDLCBibXYyLCBldGMuIEkgY2FuIGF1dGhvcml0YXRp
dmVseSBzdGF0ZSB0aGF0IGFsbCBoYXZlIHRoZWlyIHByb3BlciBwbGFjZS4NCj4gDQo+IEhpIEFu
amFsaSwNCj4gDQo+IEFyZSB0aGVyZSBhbnkgdXNlIGNhc2VzIG9mIFA0LVRDIHRoYXQgZG9uJ3Qg
aW52b2x2ZSBQNCBoYXJkd2FyZT8gSWYNCj4gc29tZW9uZSB3YW50ZWQgdG8gd3JpdGUgb25lIG9m
ZiBkYXRhcGF0aCBjb2RlIGZvciB0aGVpciBkZXBsb3ltZW50IGFuZA0KPiB0aGV5IGRpZG4ndCBo
YXZlIFA0IGhhcmR3YXJlIHdvdWxkIHlvdSBzdWdnZXN0IHRoYXQgdGhleSB3cml0ZSB0aGV5J3Jl
DQo+IGNvZGUgaW4gUDQtVEM/IFRoZSByZWFzb24gSSBhc2sgaXMgYmVjYXVzZSBJJ20gY29uY2Vy
bmVkIGFib3V0IHRoZQ0KPiBwZXJmb3JtYW5jZSBvZiBQNC1UQy4gTGlrZSBKb2huIHNhaWQsIHRo
aXMgaXMgbWFwcGluZyBjb2RlIHRoYXQgaXMNCj4gaW50ZW5kZWQgdG8gcnVuIGluIHNwZWNpYWxp
emVkIGhhcmR3YXJlIGludG8gYSBDUFUsIGFuZCBpdCdzIGFsc28NCj4gaW50ZXJwcmV0ZWQgZXhl
Y3V0aW9uIGluIFRDLiBUaGUgcGVyZm9ybWFuY2UgbnVtYmVycyBpbg0KPiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL3A0dGMtZGV2L2RvY3MvYmxvYi9tYWlu
L3A0LWNvbmZlcmVuY2UtMjAyMy8yMDIzUDRXb3Jrc2hvcFA0VEMucGRmX187ISFJNXBWazRMSUdB
Zm52dyFtSGlsejR4Qk1pbW5mYXBERzhCRWdxT3VQd19Nbi1LaU1IYi1hTmJsOG5COFR3Zk9mU2xl
ZUlBTmlOUkZRdFRjNXpmUjBhSzFURTJKOGxUMkZnJA0KPiBzZWVtIHRvIHNob3cgdGhhdCBQNC1U
QyBoYXMgYWJvdXQgaGFsZiB0aGUgcGVyZm9ybWFuY2Ugb2YgWERQLiBFdmVuDQo+IHdpdGggYSBs
b3Qgb2Ygd29yaywgaXQncyBnb2luZyB0byBiZSBkaWZmaWN1bHQgdG8gc3Vic3RhbnRpYWxseSBj
bG9zZQ0KPiB0aGF0IGdhcC4NCg0KQUZBSUsgUDQtVEMgY2FuIGVtaXQgWERQIG9yIGVCUEYgY29k
ZSBkZXBlbmRpbmcgdXBvbiB0aGUgc2l0dWF0aW9uLCBzb21lb25lIG1vcmUga25vd2xlZGdlYWJs
ZSBzaG91bGQgY2hpbWUgaW4uDQpIb3dldmVyLCBJIGRvbid0IGFncmVlIHRoYXQgY29tcGFyaW5n
IHRoZSBzcGVlZHMgb2YgWERQIHZzLiBQNC1UQyBzaG91bGQgZXZlbiBiZSBhIGRlY2lkaW5nIGZh
Y3Rvci4NCklmIFA0LVRDIGlzIGdvb2QgZW5vdWdoIGZvciBhIGxvdCBvZiBhcHBsaWNhdGlvbnMs
IHRoYXQgaXMgZmluZSBieSBtZSBhbmQgb3ZlciB0aW1lIGl0J2xsIG9ubHkgZ2V0IGJldHRlci4N
CklmIHdlIGhlbGQgYmFjayBldmVyeSBpbm5vdmF0aW9uIGJlY2F1c2UgaXQgd2FzIHNsb3dlciB0
aGFuIHNvbWV0aGluZyBlbHNlLCBwcm9ncmVzcyB3b3VsZCBzdWZmZXIuDQo+IA0KPiBUaGUgcmlz
ayBpZiB3ZSBhbGxvdyB0aGlzIGludG8gdGhlIGtlcm5lbCBpcyB0aGF0IGEgdmVuZG9yIG1pZ2h0
IGJlDQo+IHRlbXB0ZWQgdG8gcG9pbnQgdG8gUDQtVEMgcGVyZm9ybWFuY2UgYXMgYSBiYXNlbGlu
ZSB0byBqdXN0aWZ5IHRvDQo+IGN1c3RvbWVycyB0aGF0IHRoZXkgbmVlZCB0byBidXkgc3BlY2lh
bGl6ZWQgaGFyZHdhcmUgdG8gZ2V0DQo+IHBlcmZvcm1hbmNlLCB3aGVyZWFzIGlmIFhEUCB3YXMg
dXNlZCBtYXliZSB0aGV5IGRvbid0IG5lZWQgdGhlDQo+IHBlcmZvcm1hbmNlIGFuZCBjb3N0IG9m
IGhhcmR3YXJlLg0KDQpJIHJlYWxseSBkb24ndCBidXkgdGhpcyBhcmd1bWVudCwgaXQncyBGVUQu
IExldCdzIGp1ZGdlIFA0LVRDIG9uIGl0cyBtZXJpdHMsIG5vdCBwcmVqdWRnZSBpdCBhcyBhIHBs
b3kgdG8gc2VsbCB2ZW5kb3IgaGFyZHdhcmUuDQoNCj4gTm90ZSwgdGhpcyBzY2VuYXJpbyBhbHJl
YWR5IGhhcHBlbmVkDQo+IG9uY2UgYmVmb3JlLCB3aGVuIHRoZSBEUERLIGpvaW5lZCBMRiB0aGV5
IG1hZGUgYm9ndXMgY2xhaW1zIHRoYXQgdGhleQ0KPiBnb3QgYSAxMDB4IHBlcmZvcm1hbmNlIG92
ZXIgdGhlIGtlcm5lbC0tIGhhZCB0aGV5IHB1dCBhdCBsZWFzdCB0aGUNCj4gc2xpZ2h0ZXN0IGVm
Zm9ydCBpbnRvIHR1bmluZyB0aGUga2VybmVsIHRoYXQgd291bGQgaGF2ZSBkcm9wcGVkIHRoZQ0K
PiBkZWx0YSBieSBhbiBvcmRlciBvZiBtYWduaXR1ZGUsIGFuZCBzaW5jZSB0aGVuIHdlJ3ZlIHBy
ZXR0eSBtdWNoDQo+IGNsb3NlZCB0aGUgZ2FwIChhY3R1YWxseSwgdGhpcyBpcyBwcmVjaXNlbHkg
d2hhdCBtb3RpdmF0ZWQgdGhlDQo+IGNyZWF0aW9uIG9mIFhEUCBzbyBJIGd1ZXNzIHRoYXQgc3Rv
cnkgaGFkIGEgaGFwcHkgZW5kaW5nISkgLiBUaGVyZSBhcmUNCj4gY2lyY3Vtc3RhbmNlcyB3aGVy
ZSBoYXJkd2FyZSBvZmZsb2FkIG1heSBiZSB3YXJyYW50ZWQsIGJ1dCBpdCBuZWVkcyB0bw0KPiBi
ZSBob25lc3RseSBqdXN0aWZpZWQgYnkgY29tcGFyaW5nIGl0IHRvIGFuIG9wdGltaXplZCBzb2Z0
d2FyZQ0KPiBzb2x1dGlvbi0tIHNvIGluIHRoZSBjYXNlIG9mIFA0LCBpdCBzaG91bGQgYmUgY29t
cGFyZWQgdG8gd2VsbCB3cml0dGVuDQo+IFhEUCBjb2RlIGZvciBpbnN0YW5jZSwgbm90IFA0LVRD
Lg0KDQpJIHN0cm9uZ2x5IGRpc2FncmVlIHRoYXQgaXQgIml0IG5lZWRzIHRvIGJlIGhvbmVzdGx5
IGp1c3RpZmllZCBieSBjb21wYXJpbmcgaXQgdG8gYW4gb3B0aW1pemVkIHNvZnR3YXJlIHNvbHV0
aW9uLiINClNheXMgd2hvPyBUaGlzIGlzIG5vIG1vcmUgZmFjdHVhbCB0aGFuIHNheWluZyAiQyBv
ciBnb2xhbmcgbmVlZCB0byBiZSBqdWRnZWQgYnkgY29tcGFyaW5nIGl0IHRvIGFzc2VtYmx5IGxh
bmd1YWdlLiINClRvZGF5IHRoZSBnYXAgYmV0d2VlbiBDIGFuZCBhc3NlbWJseSBpcyBzbWFsbCwg
YnV0IHdheSBiYWNrIGluIG15IGNhcmVlciwgQyB3YXMgd2F5IHNsb3dlci4NCk92ZXIgdGltZSBv
cHRpbWl6aW5nIGNvbXBpbGVycyBoYXZlIGNsb3NlZCB0aGUgZ2FwLiBXaG8ncyB0byBzYXkgUDQg
dGVjaG5vbG9naWVzIHdvbid0IGRvIHRoZSBzYW1lPw0KUDQtVEMgY2FuIGJlIGp1ZGdlZCBvbiBp
dHMgb3duIG1lcml0cyBmb3IgaXRzIHV0aWxpdHkgYW5kIHByb2R1Y3Rpdml0eS4gSSBjYW4ndCBz
dHJlc3MgZW5vdWdoIHRoYXQgUDQgaXMgdmVyeSBwcm9kdWN0aXZlIHdoZW4gYXBwbGllZCB0byBj
ZXJ0YWluIHByb2JsZW1zLg0KDQpOb3RlLCBQNC1CTXYyIGhhcyBiZWVuIHVzZWQgYnkgdGhvdXNh
bmRzIG9mIGRldmVsb3BlcnMsIHJlc2VhcmNoZXJzIGFuZCBzdHVkZW50cyBhbmQgaXQgaXMgcmVs
YXRpdmVseSBzbG93LiBZZXQgdGhhdCBkb2Vzbid0IGRldGVyIHVzZXJzLg0KVGhlcmUgaXMgYSBH
b29nbGUgU3VtbWVyIG9mIENvZGUgcHJvamVjdCB0byBhZGQgUE5BIHN1cHBvcnQsIHJhdGhlciBh
bWJpdGlvdXMuIEhvd2V2ZXIsIFA0LVRDIGFscmVhZHkgcGFydGlhbGx5IHN1cHBvcnRzIFBOQSBh
bmQgdGhlIGdhcCBpcyBjbG9zaW5nLg0KSSBmZWVsIGxpa2UgUDQtVEMgY291bGQgcmVwbGFjZSB0
aGUgdXNlIG9mIEJNdjIgaW4gYSBsb3Qgb2YgYXBwbGljYXRpb25zIGFuZCBpZiBpdCB3ZXJlIHVw
c3RyZWFtZWQsIGl0J2QgZXZlbnR1YWxseSBiZSBhdmFpbGFibGUgb24gYWxsIExpbnV4IG1hY2hp
bmVzLiBUaGUgYWJpbGl0eSB0byB3cml0ZSBjdXN0b20gZXh0ZXJucw0KaXMgdmVyeSBjb21wZWxs
aW5nLiBFdmVudHVhbCBIVyBvZmZsb2FkIHVzaW5nIHRoZSBzYW1lIGNvZGUgd2lsbCBiZSBnYW1l
LWNoYW5naW5nLiBCbXYyIGlzIGEgYmlnIGMrKyBwcm9ncmFtIGFuZCBzb21ld2hhdCBpbnRpbWlk
YXRpbmcgdG8gZGlnIGludG8gdG8gbWFrZSBlbmhhbmNlbWVudHMsIGVzcGVjaWFsbHkgYXQgdGhl
IGFyY2hpdGVjdHVyYWwgbGV2ZWwuICANClRoZXJlIGlzIG5vIEhXIG9mZmxvYWQgcGF0aCwgYW5k
IGl0J3Mgbm90IHJlYWxseSBmYXN0LCBzbyBpdCByZW1haW5zIG1haW5seSBhIHJlc2VhcmNoeS10
aGluZyBhbmQgd2lsbCBzdGF5IHRoYXQgd2F5LiBQNC1UQyBjb3VsZCBzcGFuIHRoZSBuZWVkcyBm
cm9tIHJlc2VhcmNoIHRvIHByb2R1Y3Rpb24gaW4gU1csIGFuZCBwZXJmb3JtYW50IHByb2R1Y3Rp
b24gd2l0aCBIVyBvZmZsb2FkLg0KPiANCj4gVG9tDQo+IA0KPiA+DQo+ID4NCj4gPiBBbmphbGkN
Cj4NCg==

