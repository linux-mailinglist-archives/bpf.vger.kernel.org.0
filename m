Return-Path: <bpf+bounces-30589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE08CF026
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 18:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4951F2194D
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 16:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D1E86134;
	Sat, 25 May 2024 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h0itpr+G"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD6487A5;
	Sat, 25 May 2024 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716655406; cv=fail; b=mG/FhxKLNG908tlgOvaG7drvqM+eRLPLksoj0H0AyQeTeh2frlUnKHftKA/fALYwVeWVK2yJ+KwPAxdXTOy2Kukfg90gbFoQBD7g5ys7zDCSLehuYWVpsgK4e37kKZy05e8eo+rLBRFW4j80P0Q+Ci9AgNXoOTrFlcT3NfROptM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716655406; c=relaxed/simple;
	bh=a5PyUc8veWVh056K0ACvg5jcAJzZh9eN6jVcnybxyLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bbaHwv8om5ZsV1HOsRFR7Rd72e/Rlej82WaGDDhVlaGa2D3BwbZjHMxLSV5UKC2aR5QRSOJQf9Vd54tTSfIxMfKGyEp5KN3GR0GrGzTf3X7tDYd0sWwKvYUzkPNMYr+is19bRRivNB9ADmiIv/zBiiFJDQpvD+x7mmg8oRmxMOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h0itpr+G; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QT+EkV0Q/FelE3QjGhG+3rIB6QPZAxm4N6m4G0SabtHCqMbL1NMN9BdS8pODwIIK++lIQG45QT+21IyXBGsUsTrGw+2HKH5Dc8qIQuhBfPaKkywJQ+oTABQfxXV+jga1+6Hi4xa0Q7vJVVL686E/tSCpYm0VgcUJdoTi4g6F3ft/+aRfiWFN+TCXHGgp2TzJ4xGVa4HKEr/PA721hJZEq50jr9fnwvDZa150SOVlrpZueiwz/uUwOawlGjCXD3vMPVDD2O/yVfUeC45rR/E6U09m05V9cT6IfI5lgTT/RAdnkLqDupk3ciqsDROFjz40FyiXzdf1QmgyownKvh4rKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5PyUc8veWVh056K0ACvg5jcAJzZh9eN6jVcnybxyLc=;
 b=m7BXhml4kq31qbdZxb8RtKBpHFKk65z2haoN569aql/spiDKPDDVSkIiZ996+F46GgRvtjn00LHcHjySP7hTkUhQYC3pntG4wdpb+rlbuikzsmL80oODRb433/WZnXIckPVVG6uQXNSEGG0G8vlwtIkrzWfzP2WiXfDg6UxNKe1bwv3cY31Z+/2d4lrE1lo43DreSCWYVoJmc4BEE5+hr4BXOZf8i14k5pHsCw9KcKAq6hdlPvM8ha8rnAs+j2kXeGKu0Ckpcvv7w0jn3h0b+wHLIv2+fm0xGsZvCW10hG3cbt4OV+rPcNZRnx6k+yV7nUfraAsYKczEjX4X/CeYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5PyUc8veWVh056K0ACvg5jcAJzZh9eN6jVcnybxyLc=;
 b=h0itpr+G5jc0Q+mtUJ9oTGQmEbkzt71+ZTUYvgwwtLIqYAyufgc0641uNaai2H/w3esJN2VLVInbIAGf+mee4DBt74xYe5vS3SWR3lC+z73Fe5SfILrBfWaNWypwWvetOIZFIwqRaAqcU/X7whXSdZkbQ2Th4NRpCZP7tmgJ71o=
Received: from MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Sat, 25 May
 2024 16:43:20 +0000
Received: from MW4PR12MB7192.namprd12.prod.outlook.com
 ([fe80::84e0:32eb:5636:6634]) by MW4PR12MB7192.namprd12.prod.outlook.com
 ([fe80::84e0:32eb:5636:6634%4]) with mapi id 15.20.7587.030; Sat, 25 May 2024
 16:43:20 +0000
From: "Jain, Vipin" <Vipin.Jain@amd.com>
To: "Singhai, Anjali" <anjali.singhai@intel.com>, "Hadi Salim, Jamal"
	<jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Network Development <netdev@vger.kernel.org>,
	"Chatterjee, Deb" <deb.chatterjee@intel.com>, "Limaye, Namrata"
	<namrata.limaye@intel.com>, tom Herbert <tom@sipanda.io>, Marcelo Ricardo
 Leitner <mleitner@redhat.com>, "Shirshyad, Mahesh"
	<Mahesh.Shirshyad@amd.com>, "Osinski, Tomasz" <tomasz.osinski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Vlad
 Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, Khalid Manaa
	<khalidm@nvidia.com>, =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?=
	<toke@redhat.com>, Victor Nogueira <victor@mojatatu.com>, "Tammela, Pedro"
	<pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, Andy Fingerhut
	<andy.fingerhut@gmail.com>, "Sommers, Chris" <chris.sommers@keysight.com>,
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>, "lwn@lwn.net"
	<lwn@lwn.net>
Subject: Re: On the NACKs on P4TC patches
Thread-Topic: On the NACKs on P4TC patches
Thread-Index: AQHaq3tcfyyZ4s655EaSNewPjRegt7Gj1UeAgAAMQQCAABhMAIAC8Q6xgAFCQwE=
Date: Sat, 25 May 2024 16:43:20 +0000
Message-ID:
 <MW4PR12MB719209644426A0F5AE18D2E897F62@MW4PR12MB7192.namprd12.prod.outlook.com>
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
In-Reply-To:
 <MW4PR12MB71927C9E4B94871B45F845DF97F52@MW4PR12MB7192.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-25T16:43:20.546Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7192:EE_|SA3PR12MB9178:EE_
x-ms-office365-filtering-correlation-id: 1876b30e-1a0b-4ef1-3006-08dc7cd9c961
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmtZNTZybHFWSVRNMjRZdDdCbEZDcVRvbllxVzYwU0lwY2xMOWVQWHdIL3dE?=
 =?utf-8?B?ZkUxOXhJVUllaXIwakp3Q3RzNWUrcFZLK1V1aWwzZ05EZDJhU09OaHBnWDdE?=
 =?utf-8?B?YzhyNVVjVUVGSjZnYjZHOFY4TDFvRFpGU0J5QWQ3RGROUWpqcVVOY2pJOGRx?=
 =?utf-8?B?YU1PM2sySGc3Yk9YelZaemxVL2NPUWhiVWVZNkwrUEp1SkRpTS9FOHpQVllr?=
 =?utf-8?B?V3NmeWcyMXBSQlRwZEtiSC90ZnprSC9vdk5ocWJIbkFCT0lFZGxVLzZjZXpL?=
 =?utf-8?B?NEVyZHFUWFIyczlZUFlDNEE0c2pZckUzbG1sazdvaGZxcWowd3N0MCtTN0tV?=
 =?utf-8?B?VGcrRzIvdHRRcW81WWFseDMvMmNmdkVPdVFET0ZXRnhIdkQ3YzBFSHRoZTFs?=
 =?utf-8?B?SGgwcFZDSGovR21oSzJUZGphcmdlWUN6a2VhUHYwMkhCa3Era29jNWNLNmRZ?=
 =?utf-8?B?dTZUQklyVE44N3lzNEFzQTEvZnZ1REw1RUpRQ1V0RzFISHVJV0NEZmc3RTZq?=
 =?utf-8?B?QktuL1UxMTNpNkVWN1loZE1RWHJMWUVxWldyNTlCNkZaajlPQmt0b0tQRFkx?=
 =?utf-8?B?dkJFRURTWEpsR0RuL2kzWWlvNVFPak9iT1BsakhpV1NTcStqVWpYYUYzb2pr?=
 =?utf-8?B?Y1YzblQwRWJ4dGFpTXBWOGJXTlVBV29lOElCbW4zcXhXSjZoOXVxK0w1WDJs?=
 =?utf-8?B?aXJvUmY5Z2FmbFprQmFmUUJsa01VenJ6Z05aaVhuWkFacm9sVUQ0blR4ekZL?=
 =?utf-8?B?YUdXZHZZNHhDeGJ5Q0c5T05MZGtFTldIaTFCNW9ZcXUyZWMwK0p0K2tBRHBv?=
 =?utf-8?B?VWExTUJTTGhLV2NSMm5mK2dxQnpONlZWMUV1TysrVitQNXFmbS9zYVlBVm43?=
 =?utf-8?B?TUR1dDVFcFdPWE1wODFrRTg5MlY2RGNKOHpSSUk2TU9HaTJzbU1QYzhRWnBD?=
 =?utf-8?B?NDZLTFJtcjcrZnQyaXp3dWFlRXVsK3dBRGNPNis2OTJFdlZJTkdWQXVXUmQ3?=
 =?utf-8?B?SE5EdGlTY210dHp6dUhHSFh6NVhlaE9GSlZQVVVJRGhjTHBGR0VienRTZDdk?=
 =?utf-8?B?VlJpSHYydHdoNVhqN0FJVFE5Q0hKYUVYUE12RnliSUUvNG93bTI5cXR6SUdi?=
 =?utf-8?B?YW8yYndVSG9WMmhCUjhMWG5sVEljc2luenhaWlhJV0Zwanh4WHd1T0E2VURh?=
 =?utf-8?B?Z2RzZUhRUFNBN3NqMFgyQ1RyTWxFQzloVExOYndKeXpOT2dmZnoxYW9wZW1o?=
 =?utf-8?B?NXJsQUw1VmxRQS9lRlBIV3pGelN2QUlPTytWalI1ZnRrQkw3NUZ1WDFsanpp?=
 =?utf-8?B?RUNYWjNxTjVqSlpTSkFTVGp3YjBPdVo3L28zMm94L0QzSFJZQjBtTVZ1MmNa?=
 =?utf-8?B?QlluNDJpSGhKSzJ3bjVEZFVrWjlNZ0E4ajBhWGVvOW1KeXVIZkNkcVBvRDZk?=
 =?utf-8?B?eWF6cDNrVEZvZDFtVlV0MVNaMVlzdzRnU05UVXhhTE1PNE0xd2ppaG4veXhB?=
 =?utf-8?B?cDEzU0VYV3VjVGNNc24vRFBxUjBaU1l1eDhaVmRLWEtSMnpSVi9nMWVIU1kw?=
 =?utf-8?B?SnV6Mk56anBTTmNCYkpvS0tnYTd1d0tady94Y3hNdHB4bzQrdGU4OU9MNTVB?=
 =?utf-8?B?ekdEM0pQSDZXNzgzZlN3T1lGNFlSNGtCVURvU3JmSm5qcG0zaFZsOGtMSmVu?=
 =?utf-8?B?c20vSzVCanZraG0vZXhXTE5UblhhdGkyb3FzZDArUGZPWDlWMnJUVjVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWpwbHZ1TGVNNE54b29UQzNRSDFNUUFDMStjTHpOYlN2QlJRakIxQUsrUGxK?=
 =?utf-8?B?d1QwVmVXMDRBRFVPaTRhVVZXcFM5QS9SUlRTS1hlajVVVkVNSzRRZDhTZGxt?=
 =?utf-8?B?L1BuMFAzOVVOTzVkeWlXWFpFY0lmUDR0SHJTUndFdCtXNWdZZVVrL0xYbXB6?=
 =?utf-8?B?UlBGMEp6aTl0MThSTytXMTJyMzA0SG5hdCs1bWQ2amtZRzk3SENuS2Qyc0gx?=
 =?utf-8?B?VXIxcXJLVHJDOGRuWHYvaFh1aEhFUUZjYUJoQ0tEcmlGV1k0R1RTc0hVL3ZH?=
 =?utf-8?B?RnBOTTZBWnBCNGQ4SDJIUURBcHY2YU1uVnlUM2QvTzlaMjhVeUUxRGJMeWNx?=
 =?utf-8?B?TUNZM0NMQzR1aUdkVkZxbnpiUmxoRW9QTHlEZkFNSGp3aG9tNmtoQUViY3B6?=
 =?utf-8?B?Uzk1ZUZQVTUwUVBpNU9jV2Y2T3YzUk1LSGNsdU5NdXc0VWRGbjNaSG1YNVJR?=
 =?utf-8?B?eUxoWHd2WmpQcHdNQ1NCNmc5Umt2QjFzS0d0b2Z2RG8veVloUmxXUjh4SzBC?=
 =?utf-8?B?dmM3bENLVEZ0cHBkZmJjKzdZdEFOckN0ZzI0cGVhc2k4czVZdnJOb3JyaGxV?=
 =?utf-8?B?bk1zaHpxeW5FRzdCVjA0U0hiQXRuWFBWK21YcDNDNm1CalFmczFSenJlczZH?=
 =?utf-8?B?eDFLK0JLbFZ6dmZoWkhucFVxelJib1ptR0RlQVZBQXVZVEs3YkluaFZjb3Ix?=
 =?utf-8?B?eG0xQkpYTVFTTWYzcUYwUnA4Z0pwWCsyejlnTWZkdWZwakpaa3pHcnFpcjRh?=
 =?utf-8?B?OXgwbG03V0pFRDc5OEZOSE1tbmFKbE5UMFVmTys5amp4Y1hEeDlDUkMxdWVX?=
 =?utf-8?B?K3BNVWlIWTkwMEtNVVlGbi84cU1xYy9CdEg3Zi80TE5kOVl4Q0ZKVnJoZmQ4?=
 =?utf-8?B?SWFjbVNFYVMxc2hNT2pWVzE3Q3cvM1ZocHNianhZaTd4U2dhUmlPT3U4Q281?=
 =?utf-8?B?MkJXMHgwSWtkbFkrUXJsVy9GanNwT0paMHA2SHh3dHNKRnJJdHRWOVIrUlRi?=
 =?utf-8?B?Y29UdGhDS2FQYW5RKytiaEFjd1k3WE1LWDIwNW5kWk9RTEFSSWlMUDBVbUFX?=
 =?utf-8?B?d1pDMVJCWnN1ZmNHeEltMWc4TVN5dEFYMCtybEJOZ2J1eUFqMWV0RWhXNXRm?=
 =?utf-8?B?YVd3VUZaM25yYlNIU3VoOXd6T1Y0d3FkUGxYQlRzeDlmc29WRlVUVnhaU0h4?=
 =?utf-8?B?c1p5UTJxck95dm0vd3VVV2h5K2lyMlRtckZLUHdWeWluZi84ZTd1cm1vZnpi?=
 =?utf-8?B?dVhPeU9qVXFFdm5hUzlNNTFmTzdZZmVVUThSK2dIbE05elVOdE5rbERMdFdY?=
 =?utf-8?B?S3d2cHNXak9SYjZYQ1RjR25hUFFGYXI1TUFjSElSVSs0SGwvbmVxbW9ONVdI?=
 =?utf-8?B?UzZlbUt0Nlh1QXVhQjc4KyttSWNLMTNKbHNncm1XNWhxV2hrUGRQZm9CVW1v?=
 =?utf-8?B?ZHBrTmY5NFZNRnp2T2ljQVVLc1plUHFJYThBWVFJYjZEWm9KOUpnZCtFWFZo?=
 =?utf-8?B?UkNHR01SZVRLSGlVMWZ6aS83d2QrVkJSZ05JSFBLNnd0Tk1NQ2NyMU95aGMr?=
 =?utf-8?B?K3FmSGF6OEQ4V2NMTHVZNElTZ3dLYU1ncXJaL2hUK0V1b3hnbmFZMXg5N2NM?=
 =?utf-8?B?UTQ5MG9VT1c5ampqWC9kdTJmN3I2TG9YQzdMYmNOeFhIeXgyR29yUFhVcjBP?=
 =?utf-8?B?UG9tNU1OWGh6RURMQktlbUh3dmtucFkzRWpZUFpKQ2l1dzJtMTk1YVZQNTlJ?=
 =?utf-8?B?OElTQm9DZUFaa1V5M3ZiMkQvL05EK1hRTUwyK2N3NXdOSjJNdDhiNHJjejlH?=
 =?utf-8?B?Y2JOVWY5L0p3Q3I1bmJOdkc3QjZsMXN6OVY5eXVmMElmdWVxRDFJZTVvdm5H?=
 =?utf-8?B?dE5aTVVOWW5UWUJndkxpMVRsQmI1b1RhZzA0bGpvT0RIdDNWU1FyWkhGWldz?=
 =?utf-8?B?QU8rbUpBY2x2OVFwcHhWTnk0UUNUUDNidXVnODU5aUhzRjd2TGlDb3lKaWhH?=
 =?utf-8?B?Q0tseGdhNENPUVJhNEUxbU9xWmdDN0k3Ky9rZ1dsYVQvNFZPckt0RTkxa2lt?=
 =?utf-8?B?SjZSOC9hMjh3ODhSOVIvZE5vZXp5d3F3Mkg0WDdqOHU0SlBvUGJKWGJkRkl3?=
 =?utf-8?Q?Pd9w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1876b30e-1a0b-4ef1-3006-08dc7cd9c961
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2024 16:43:20.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JyUZYrpUC1TCj8IyS6EAcddj1SZGw8qJU7CzTWb93In9K310UA2ro5q2CvSfCeXY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KTXkgYXBvbG9naWVzLCBlYXJsaWVyIGVtYWlsIHVzZWQgaHRtbCBhbmQgd2FzIGJsb2NrZWQg
YnkgdGhlIGxpc3QuLi4NCk15IHJlc3BvbnNlIGF0IHRoZSBib3R0b20gYXMgIlZKPiINCg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogSmFpbiwgVmlwaW4g
PFZpcGluLkphaW5AYW1kLmNvbT4NClNlbnQ6IEZyaWRheSwgTWF5IDI0LCAyMDI0IDI6MjggUE0N
ClRvOiBTaW5naGFpLCBBbmphbGkgPGFuamFsaS5zaW5naGFpQGludGVsLmNvbT47IEhhZGkgU2Fs
aW0sIEphbWFsIDxqaHNAbW9qYXRhdHUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVs
Lm9yZz4NCkNjOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+OyBBbGV4ZWkgU3Rhcm92
b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+OyBOZXR3b3JrIERldmVsb3BtZW50
IDxuZXRkZXZAdmdlci5rZXJuZWwub3JnPjsgQ2hhdHRlcmplZSwgRGViIDxkZWIuY2hhdHRlcmpl
ZUBpbnRlbC5jb20+OyBMaW1heWUsIE5hbXJhdGEgPG5hbXJhdGEubGltYXllQGludGVsLmNvbT47
IHRvbSBIZXJiZXJ0IDx0b21Ac2lwYW5kYS5pbz47IE1hcmNlbG8gUmljYXJkbyBMZWl0bmVyIDxt
bGVpdG5lckByZWRoYXQuY29tPjsgU2hpcnNoeWFkLCBNYWhlc2ggPE1haGVzaC5TaGlyc2h5YWRA
YW1kLmNvbT47IE9zaW5za2ksIFRvbWFzeiA8dG9tYXN6Lm9zaW5za2lAaW50ZWwuY29tPjsgSmly
aSBQaXJrbyA8amlyaUByZXNudWxsaS51cz47IENvbmcgV2FuZyA8eGl5b3Uud2FuZ2NvbmdAZ21h
aWwuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1h
emV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgVmxhZCBCdXNsb3YgPHZsYWRidUBudmlkaWEuY29t
PjsgU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPjsgS2hhbGlkIE1hbmFhIDxraGFsaWRt
QG52aWRpYS5jb20+OyBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4gPHRva2VAcmVkaGF0LmNvbT47
IFZpY3RvciBOb2d1ZWlyYSA8dmljdG9yQG1vamF0YXR1LmNvbT47IFRhbW1lbGEsIFBlZHJvIDxw
Y3RhbW1lbGFAbW9qYXRhdHUuY29tPjsgRGFseSwgRGFuIDxkYW4uZGFseUBpbnRlbC5jb20+OyBB
bmR5IEZpbmdlcmh1dCA8YW5keS5maW5nZXJodXRAZ21haWwuY29tPjsgU29tbWVycywgQ2hyaXMg
PGNocmlzLnNvbW1lcnNAa2V5c2lnaHQuY29tPjsgTWF0dHkgS2Fkb3NoIDxtYXR0eWtAbnZpZGlh
LmNvbT47IGJwZiA8YnBmQHZnZXIua2VybmVsLm9yZz47IGx3bkBsd24ubmV0IDxsd25AbHduLm5l
dD4NClN1YmplY3Q6IFJlOiBPbiB0aGUgTkFDS3Mgb24gUDRUQyBwYXRjaGVzDQoNCltBTUQgT2Zm
aWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQoNCg0KSSBj
YW4gYXNjZXJ0YWluIChmcm9tIEFNRCkgdGhhdCB3ZSBoYXZlIHN0YXRlZCBpbnRlcmVzdCBpbiwg
YW5kIGFyZSBpbiBmdWxsIHN1cHBvcnQgb2YgUDRUQy4NCg0KSGFwcHkgdG8gZWxhYm9yYXRlIG1v
cmUgaWYgbmVlZGVkLg0KDQpUaGFuayB5b3UsDQpWaXBpbiBKYWluDQpTciBGZWxsb3cgRW5naW5l
ZXIsIEFNRA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTog
U2luZ2hhaSwgQW5qYWxpIDxhbmphbGkuc2luZ2hhaUBpbnRlbC5jb20+DQpTZW50OiBXZWRuZXNk
YXksIE1heSAyMiwgMjAyNCA1OjMwIFBNDQpUbzogSGFkaSBTYWxpbSwgSmFtYWwgPGpoc0Btb2ph
dGF0dS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KQ2M6IFBhb2xvIEFi
ZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJv
dm9pdG92QGdtYWlsLmNvbT47IE5ldHdvcmsgRGV2ZWxvcG1lbnQgPG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc+OyBDaGF0dGVyamVlLCBEZWIgPGRlYi5jaGF0dGVyamVlQGludGVsLmNvbT47IExpbWF5
ZSwgTmFtcmF0YSA8bmFtcmF0YS5saW1heWVAaW50ZWwuY29tPjsgdG9tIEhlcmJlcnQgPHRvbUBz
aXBhbmRhLmlvPjsgTWFyY2VsbyBSaWNhcmRvIExlaXRuZXIgPG1sZWl0bmVyQHJlZGhhdC5jb20+
OyBTaGlyc2h5YWQsIE1haGVzaCA8TWFoZXNoLlNoaXJzaHlhZEBhbWQuY29tPjsgT3NpbnNraSwg
VG9tYXN6IDx0b21hc3oub3NpbnNraUBpbnRlbC5jb20+OyBKaXJpIFBpcmtvIDxqaXJpQHJlc251
bGxpLnVzPjsgQ29uZyBXYW5nIDx4aXlvdS53YW5nY29uZ0BnbWFpbC5jb20+OyBEYXZpZCBTLiBN
aWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2ds
ZS5jb20+OyBWbGFkIEJ1c2xvdiA8dmxhZGJ1QG52aWRpYS5jb20+OyBTaW1vbiBIb3JtYW4gPGhv
cm1zQGtlcm5lbC5vcmc+OyBLaGFsaWQgTWFuYWEgPGtoYWxpZG1AbnZpZGlhLmNvbT47IFRva2Ug
SMO4aWxhbmQtSsO4cmdlbnNlbiA8dG9rZUByZWRoYXQuY29tPjsgVmljdG9yIE5vZ3VlaXJhIDx2
aWN0b3JAbW9qYXRhdHUuY29tPjsgVGFtbWVsYSwgUGVkcm8gPHBjdGFtbWVsYUBtb2phdGF0dS5j
b20+OyBKYWluLCBWaXBpbiA8VmlwaW4uSmFpbkBhbWQuY29tPjsgRGFseSwgRGFuIDxkYW4uZGFs
eUBpbnRlbC5jb20+OyBBbmR5IEZpbmdlcmh1dCA8YW5keS5maW5nZXJodXRAZ21haWwuY29tPjsg
U29tbWVycywgQ2hyaXMgPGNocmlzLnNvbW1lcnNAa2V5c2lnaHQuY29tPjsgTWF0dHkgS2Fkb3No
IDxtYXR0eWtAbnZpZGlhLmNvbT47IGJwZiA8YnBmQHZnZXIua2VybmVsLm9yZz47IGx3bkBsd24u
bmV0IDxsd25AbHduLm5ldD4NClN1YmplY3Q6IFJFOiBPbiB0aGUgTkFDS3Mgb24gUDRUQyBwYXRj
aGVzDQoNCkNhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwg
U291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlj
a2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCg0KDQpPbiBXZWQsIE1heSAyMiwgMjAyNCBhdCA2
OjE54oCvUE0gSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4gd3JvdGU6DQoNCj4+IEFG
QUlDVCB0aGVyZSdzIHNvbWUgYnV0IG5vdCB2ZXJ5IHN0cm9uZyBzdXBwb3J0IGZvciBQNFRDLA0K
DQpPbiBXZWQsIE1heSAyMiwgMjAyNCBhdCA0OjA04oCvUE0gSmFtYWwgSGFkaSBTYWxpbSA8amhz
QG1vamF0YXR1LmNvbSA+IHdyb3RlOg0KPkkgZG9udCBhZ3JlZS4gUGFvbG8gYXNrZWQgdGhpcyBx
dWVzdGlvbiBhbmQgYWZhaWsgSW50ZWwsIEFNRCAoYm90aCBidWlsZCBQNC1uYXRpdmUgTklDcykg
YW5kIHRoZSBmb2xrcyBpbnRlcmVzdGVkIGluIHRoZSBNUyBEQVNIIHByb2plY3QgPnJlc3BvbmRl
ZCBzYXlpbmcgdGhleSBhcmUgaW4gc3VwcG9ydC4gTG9vayBhdCB3aG8gaXMgYmVpbmcgQ2NlZC4g
QSBsb3Qgb2YgdGhlc2UgZm9sa3Mgd2hvIGF0dGVuZCBiaXdlZWtseSBkaXNjdXNzaW9uIGNhbGxz
IG9uIFA0VEMuID5TYW1wbGU6DQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L0lBMFBS
MTdNQjcwNzBCNTFBOTU1RkI4NTk1RkZCQTVGQjk2NUUyQElBMFBSMTdNQjcwNzAubmFtcHJkMTcu
cHJvZC5vdXRsb29rLmNvbS8NCg0KRldJVywgSW50ZWwgaXMgaW4gZnVsbCBzdXBwb3J0IG9mIFA0
VEMgYXMgd2UgaGF2ZSBzdGF0ZWQgc2V2ZXJhbCB0aW1lcyBpbiB0aGUgcGFzdC4NCg0KVko+IEkg
Y2FuIGFzY2VydGFpbiAoZnJvbSBBTUQpIHRoYXQgd2UgaGF2ZSBzdGF0ZWQgaW50ZXJlc3QgaW4s
IGFuZCBhcmUgaW4gZnVsbCBzdXBwb3J0IG9mIFA0VEMuIEhhcHB5IHRvIGVsYWJvcmF0ZSBtb3Jl
IGlmIG5lZWRlZC4NClZKPiBUaGFua3MsIFZpcGluDQo=

