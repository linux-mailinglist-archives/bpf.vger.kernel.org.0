Return-Path: <bpf+bounces-30359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D18CCAE0
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 04:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD922282B58
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 02:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312FD13AA31;
	Thu, 23 May 2024 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b="g8uPFO0U";
	dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b="qAjZtfi7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-003cac01.pphosted.com (mx0b-003cac01.pphosted.com [205.220.173.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ED61852;
	Thu, 23 May 2024 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.173.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716432745; cv=fail; b=U+7jgrvfLrqRh7ezSim1BG1oMzrjBmzgOdAOwT5OonuHeAikslBoMpz34i3NLe2kXv1tT9KIKJr8Bd+kaM9OAaL8+xexy3S0Y/5E9Q+2OTRNm+73J28fupFpps+ohHJj9EWP3t667Xwdtkn4N2t9FCmzyfnTgfa4v2kZexcGcxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716432745; c=relaxed/simple;
	bh=LxytKdqo52Q4Oj5k0kie+A/KaT7v1CnyoqI2K6iUoB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WD+U+jM08oZjrunFJIDBkHD4wtCgCmaGkNwUFph6zXxJWWWeAdmqk3OukZbysCmgY/MVLZAgRW4dD84ztPN3Hi7PLvdn+jjPmgDHzi9jqGoLkYHboWOtUxs5bTcxj7SoOswQ+wXGB2eSt6zbbhZB6IbtrysPcwhw37zsQht1c/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com; spf=pass smtp.mailfrom=keysight.com; dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b=g8uPFO0U; dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b=qAjZtfi7; arc=fail smtp.client-ip=205.220.173.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=keysight.com
Received: from pps.filterd (m0187216.ppops.net [127.0.0.1])
	by mx0b-003cac01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44N0Llfv016448;
	Wed, 22 May 2024 19:29:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=ppfeb2020;
 bh=LxytKdqo52Q4Oj5k0kie+A/KaT7v1CnyoqI2K6iUoB0=;
 b=g8uPFO0Usyj9gwVOIU0Vs9uXyhKWcXhogB3P81pGrsDiYqK+YWCOQCyBoDadqsuCvn0Q
 FcICndpC1BPOLkVBRhiU/AsR3hKaK/qckNkvOz4h5Se9UFh8fMWJPPIx12hXd84Z6o6B
 uncNOmNKf+zRefibQuYE6Dy9u0IP9ZUGaUqvhXCCPsxb+YShI3QiHyWFJV5tfrjGi5rx
 kdtW5dgeXKpi5NeFsxG0b3HKxZT7CPdby3qy6Lk6teoZE0TrbfBISVKZIxZ9SpYYVnG2
 3Ej2AfSw1THFg6PCglyzNy42/PSqtyO3nw+AVl8gJ5guD56BWiIY7ICmh2EKnJY72BJW Bg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 3y6t7996v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 19:29:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyIN+XeappSiuKebYnWiGysD7/iVMfB8ncLtbvGV7YtQFZ+6O4d5tjBG2WSTFeU6L+sbOiBvh8FR/CbfVq6tIvmYJ1e8JDdhYGbKljZYW/cWEsT7lusrIrq+Se0O2NoytyeXWhnZ9whi7vHqV7M0Bj7WjBD0Dzipwo84NDYLVfEe4hZZ1csXkHK28NjN5N6UtkLAkLk1I+CAY06yCb0lkK226jKalGC5XROpU5Wx+BawuvQ3RtX6Ch77gUS2IHRM16hQglk2kotCiJVl6w9FGy7DJU8+O267Q5Ikir5VgVODRB7RBLF5uJTe7cvu5PUXDrlw0HNsJ0RkY56JfzxYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxytKdqo52Q4Oj5k0kie+A/KaT7v1CnyoqI2K6iUoB0=;
 b=Nq8cZpv3xl0INdyOOisIx8UPBerxD1En5QMhG+zsikVExUgQGiqG9aIt5/ifBGD/pNqiYrKtjQVqgRi+PcsjbG0LUTsbjUE2ctBMaSItwDbY+ceU45akwBTrQLYX3SXWap3KbwqF6ggxPGtfC5r+aGCT04C7HzSCYhWtSiQ3K8l8FRgqmF3X3g1wmacZTWRNhmy/YSVF1LjE+42fWx9ME06UXPgCnAwB7IhL/+xt/aV3rl57EkxbxJpcSGDUY1w/TuZy4UIx0iWbSkhggDJg+nSDzjkywHTZZcxnS3Qon1YCtdhchNMFSgrADL1ljzIFmMQBmhdGoOAdrIeDFikI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxytKdqo52Q4Oj5k0kie+A/KaT7v1CnyoqI2K6iUoB0=;
 b=qAjZtfi7jc/nDvibGibnhHqKCMJSwt+pbH6k95KiRGVI3/td3Oo6myjXBEtUeJYbmPes0vm9Vgo0czurwc9U0WhYulH2uygQ5Iya/hNarOL0giIyPTyO6tIDomspnUcWvs4P/kOQpHaDi/LfFctQsnNhSVtEtKoIx/uyud50aWg=
Received: from SN6PR17MB2110.namprd17.prod.outlook.com (2603:10b6:805:4e::33)
 by LV8PR17MB7249.namprd17.prod.outlook.com (2603:10b6:408:263::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 02:29:47 +0000
Received: from SN6PR17MB2110.namprd17.prod.outlook.com
 ([fe80::897f:512f:1cc5:c1c2]) by SN6PR17MB2110.namprd17.prod.outlook.com
 ([fe80::897f:512f:1cc5:c1c2%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 02:29:47 +0000
From: Chris Sommers <chris.sommers@keysight.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, Tom Herbert <tom@sipanda.io>
CC: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Alexei
 Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development
	<netdev@vger.kernel.org>,
        "Chatterjee, Deb" <deb.chatterjee@intel.com>,
        Anjali Singhai Jain <anjali.singhai@intel.com>,
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
        Pedro Tammela <pctammela@mojatatu.com>,
        "Jain, Vipin" <Vipin.Jain@amd.com>, "Daly, Dan" <dan.daly@intel.com>,
        Andy
 Fingerhut <andy.fingerhut@gmail.com>,
        Matty Kadosh <mattyk@nvidia.com>, bpf
	<bpf@vger.kernel.org>,
        "lwn@lwn.net" <lwn@lwn.net>
Subject: RE: DSL vs low level language WAS(Re: On the NACKs on P4TC patches
Thread-Topic: DSL vs low level language WAS(Re: On the NACKs on P4TC patches
Thread-Index: 
 AQHaq3taEWM9VDh9Vkmz6Q1EN+6MvbGj1UeAgAAMQQCAAAXSvoAAGUOAgAAFJQCAAATiQA==
Date: Thu, 23 May 2024 02:29:47 +0000
Message-ID: 
 <SN6PR17MB2110A8E11C444ABF8167D12296F42@SN6PR17MB2110.namprd17.prod.outlook.com>
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
 <SN6PR17MB211069668AF4C8031B116B9D96EB2@SN6PR17MB2110.namprd17.prod.outlook.com>
 <CAOuuhY9b6WZd6eunVGr6QQ=sd7KLvx7OVn4ozzon3+ABRQaYeQ@mail.gmail.com>
 <CAM0EoMmXYL6DYc8UogPpS1W2rXyT0Z8JTewLonb9Eze=ofsYOg@mail.gmail.com>
In-Reply-To: 
 <CAM0EoMmXYL6DYc8UogPpS1W2rXyT0Z8JTewLonb9Eze=ofsYOg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR17MB2110:EE_|LV8PR17MB7249:EE_
x-ms-office365-filtering-correlation-id: eb1364a2-12f0-4950-4f73-08dc7ad036ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eEpKeUd4b0Y1RjFwT2RnZTZrSmI3SEwwWnB3anRvQmE2UDY5QTJiMG9xWE5o?=
 =?utf-8?B?Z3hnYVJIWjUraGlOSFo4RnBOak1sVG1UVkVJNFVUaGxyZG9LY1E0VUU3cVVN?=
 =?utf-8?B?T3RjYlFBZUs3WFFEbEFaN0RyMjhtcXpFRjNMejRlUHJJaGpaL3pCMlRsZXd4?=
 =?utf-8?B?bFJ0bVQxUThiMktTZDlWUkw3cG93MXB3cThoZDJpTXY3RWZDSCtYM29qYWt0?=
 =?utf-8?B?RnV0NWpSS1JNdWlWYXM3TlBCWGJHRW5uVXEwbTNyUjF5WkgwUVM0KzQwYUNw?=
 =?utf-8?B?TFdZTDlLOTgwZzdkaXBYaDdtV0paUGxSVEhYM3VaY09QUHBaWmRHclBMMThE?=
 =?utf-8?B?VFdiamFLT0lwbU1IejJKbHdvWTJnM3oxcFFXeWJ6b29sZFJ5WElMemE3cEp0?=
 =?utf-8?B?TytVUm1Dd0RqUWd4N3NkMEhtZCtiTU8yRi9Kb1kzK3NqdENoRHdvclR6OFll?=
 =?utf-8?B?Vy9hVzZSOFhIVnJiZFVVRFlYRVJ3NytuQVJpRnBCVzdhQVBaV0pvUEJJZlFR?=
 =?utf-8?B?K1dzVExvRzBrT2VPeGZGNVA2QS9UbndLZGZxRElva0FtTTNUNENnWEx3akdK?=
 =?utf-8?B?YjY5c1BOelRmU2pyeHdjNmJtS1VJRURuUlpJL2pHSE1YNCt4YStVYUZFSURt?=
 =?utf-8?B?OWNsU2F1U3VOMFEvN29vU2hTTkxpRlpKdGpjREladWY0bk53R1hxM3dxTXQx?=
 =?utf-8?B?UE9wcmRCa2xLMHl3WmN1aUZPYUowRzhkUkpVSFFxcUJUbi82OXVLd0RjUC9r?=
 =?utf-8?B?aUMvTGlrWlRJQXFtRjhCVXg4N0FqQ0lNWGhGbEpzZEtwVzFSOXZUaEFPaU9J?=
 =?utf-8?B?U1dTWkFzWEVIVGNqVmxpSEFycFdyUHF3Z01uaUZpaUlwOEt4ZHI5dEQ4Qk8w?=
 =?utf-8?B?LzVLcGJScVQ2b2ljR2xyYUMxQ0t0Z0c1VzVhS0ZnVk16MkNWVVpPamRKMnhu?=
 =?utf-8?B?bzZGRG1Fd3doSkRSaXl2VWNRbVBUU0Y5RCthc2hrVkNPaks0RnhNV3dFKzll?=
 =?utf-8?B?TXZtN0tXWkQrdno1Kyt3SjlJVDl6bTFNZFZ1TzNDTExyZ09GYzdPMlFaVDlH?=
 =?utf-8?B?RnFSQlRZaWZwaWFFdWtjOUFJeW1wOCtnYTJlOXAwSjBkTUczUVVNVzBXODBX?=
 =?utf-8?B?WUhmVTdZUU80SkdLWTJzVlRhQzYzeHJXMTJSekxLc054UTN0SmdqM0E4K1ly?=
 =?utf-8?B?MnhCSjZKd0wvY3pDTWlNUHVkeE5UUnA5WHd0WEppMUI3ZWdybEVCUkdpYS90?=
 =?utf-8?B?ejgzd1IwSVdiVEFVNkJVc0pjM1BiR2VjTzFFK0pZZkxJcWNsNHlwN0JOY2w0?=
 =?utf-8?B?dm9RM0dPb214bUdMZ1BWWUo2MlVLVUVqbklmdi9kR01KbjN5OFRhQ3Z1ZGR6?=
 =?utf-8?B?eXBpc2k3eFVaZUs4Q01GU2xtbjBYNmJCNEFUUDJ4N3pINjdRNEJQbnQ5WjlC?=
 =?utf-8?B?aEtWaWR2cEhtamxlZzdmZ3RIS2VUczMyZ2NpYURyV3Q4TkhNNmdVUHpyajNP?=
 =?utf-8?B?QWlHZ0V0TVNPcEVvZFFYVmtaSzlrSnljMVE5ZUZhYUFYRWhnMnVST0RaeTF6?=
 =?utf-8?B?L05YVnRVVHVJRnFmckZjcE93Y3hhOEJMYzJkclYyZ3M5Z0QvdFN2aWR5MmZv?=
 =?utf-8?B?VXZ1N2cvUjRGNDVCVEZNWHArQUxwWnA5UG9IdmRYUk1YTkR4MEJrRUxvTXRO?=
 =?utf-8?B?cTQxdmY5aWd1b0pMcU5NTWZhZTdjcmdRWnZjUGcwWUZoU25GRFlnUmI2Q1VN?=
 =?utf-8?Q?F/iY4VzUay+l0gB3lQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR17MB2110.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bWMwRE5WWE9meW1WN3UyM21SV1F6N2pCTWRONkhHRW5RY2xGNy9rdTNoUkhH?=
 =?utf-8?B?Vzh4Mll4a01GQ25DTG02dW1kSi9ld0JxeGlCYkM4U0d6VzVrcVNSTVcwWG1q?=
 =?utf-8?B?Zk9WUS81MEJpR2oxdjdXazB1T1JuQUg2NEFlNEFhZGJzTHlBQ1VHNlhqbTlH?=
 =?utf-8?B?YkRvcEtWR25hN05XVmh2M0hjanJRVEtnTGZwS21nRXF4UmtxcXZra0Nnc2dV?=
 =?utf-8?B?aWNhekVJSWRYT3ZXL1V2L1pEZkwzZXVkeDYvTDlZeGZ1T2lSWmU3cWxWdEth?=
 =?utf-8?B?Zk90Yy8yQU1OV0NJOWxNK0Zsc0I3eEN2YkRiZmpxcGtnV0pId3ZnUEx3Z0VF?=
 =?utf-8?B?RzVzUHFMUVVGRzVBZlE3ZVRHYTBtNzI4WWwwVnNZeXcvQjhOdGR2V24zNTl6?=
 =?utf-8?B?VHA2ZzB2SWpJaW5KSjQwem00Rzg1WXB2eUEzeVYyc2hBbDF3bStZZDdBaUoz?=
 =?utf-8?B?cWtjY2VCdXlyRmo5a09BcnNHZDdGeFJOMXpLTWpQbitXU3hObzRoQzd2VVZu?=
 =?utf-8?B?TTZFeEcyUm02RXVrSTdOeERodW9wT0lvSi9ISWgwVFRyQ2xSQWZHaUMrTkFG?=
 =?utf-8?B?cDg1VXh5TXpwNWFmUTY0Qkt0eXVka1VZSkxLUllIMlUzZEIvdmJuSkc0eFJJ?=
 =?utf-8?B?UXAwNlVZdjF2eHRnR1g3UlpTTEV3YnFoRUV5djdzV3hXL1lDek5Oa3ZKYk1q?=
 =?utf-8?B?T1ZjYUl6ZjgrYjVNZU8yWE5idXdtYStnSHMzdzlhaXBZWjViSVlYbW1CTnJ3?=
 =?utf-8?B?Wk9Jb2dwbE4zbmxTOXEwTlFKRkkxNy9WK05mSFFEZFZrNUJseHROVGxQMzVh?=
 =?utf-8?B?L2VtOGxNMzhGSmFpNHRoeUsyZHVQY05UUjEyRGhXWG1USEMzc0N0UFZMdHJM?=
 =?utf-8?B?SWVOVTN3c0N3eU5tVXRXUlpJeXUxZEtoSXI2L21rWnN3QjVoMGwwcDlxMVZl?=
 =?utf-8?B?Y3BSQXg5RHIvRUE0QnBnRVNJWTE4S1VOc2JUKzkrNkJJcXlPY204OFdDK2dT?=
 =?utf-8?B?Q2g2c0ZlR1ZqRzBRSk4zZ2RwQ2pjMGlESkJ6d0ZjSFZ0Y3dLVUd0ZTJGdlg0?=
 =?utf-8?B?OTRPZ3NhWlZmaHdGOVpJK3BnSW15TXlpRzk0M25EYUtWT0MxVlBseURwa2Fh?=
 =?utf-8?B?TUdpK1AvSDZVRnE5cEUxMXExUEQ2Z0E3em1vWEJRdVpVTHZhQXlZeWUyeHhq?=
 =?utf-8?B?ZSs1bEVDeSsySjZ4amdnd3d1bHJDWXphbTYzK3BGalpwWWtlT1gyeGhKZC9r?=
 =?utf-8?B?bXU4WGVTRzJ5dWE4WmdlVThkd3FNUDNhd214T1dIUUpqUW52ZWRlUE5EVURh?=
 =?utf-8?B?am1peExhb0ZTVTRnQk9NMjhGSFdMZzVUQ0NQNzhrNXpVcFNkRjdpVXFRbElk?=
 =?utf-8?B?Nmh4VkorNDhpZXIrd0dUQ0M4UVhlNVo1a3pTRWx6UkhUalZkMFdFOXhOVmM1?=
 =?utf-8?B?cG5xV1ZmM0w2N09JWVJkREpSQThjcVpEY0xFNStMNWtZcE5KaDRXRXNicnBl?=
 =?utf-8?B?ZFFOakNMdzhkL0w1WmltSjdYQVBFdXBCV3lDdGt1dU1QWXR0ZnJJT25ZUjJN?=
 =?utf-8?B?bmQ4V3QvZnJBMDk2aGtSN2QxZktIZCtSWE5PL0JuMUZVcFpMbG8zM0YzRHdP?=
 =?utf-8?B?K2tPdk9yVklGMzRlOWpLQmJXTnd1dUhQS1NWQlVYaTZ5dElQMXpjRzNIOS9O?=
 =?utf-8?B?MFBCdDMzcTZvZ1YvUVFuazgwUk1ycjQvZXJxRWVpSW42TWg0TWVMTUphRDF4?=
 =?utf-8?B?Mm5ERTRHZU03cFFyQktYdWZzaUkvZEVYNm9Gd1VYS3pYdzRKODBIeThHQ2Na?=
 =?utf-8?B?QlBrQStjakpta1ppNEVoTlFCSUVLRTBFMS9keWFJaDBQQlZPRW5BSUtqa2Vm?=
 =?utf-8?B?V3pHZEpDNTZiamdMckJ6Umh4bVkyeWpRcVo3WUNIOXZkWE1icjFzT3ZZRjZh?=
 =?utf-8?B?eXh4TnpVMVQvVEluOXJ2dW1uWGlhUU1nYzJ2aE41UXRjeXg4cWsrZ09FNkF6?=
 =?utf-8?B?Tm85UTRNU0d2bUI3MjNlS3FuL01rSkpnV1YzMXRxUnVPWnRaWGFUeGlFMU92?=
 =?utf-8?B?UmhsbU9KUGxPVGxLZ3Q5Q0Y2MWZhcERjWVBWM2wrMGJJYllFNzRJUEN3MllG?=
 =?utf-8?B?TEVudUlBRG9ZZTUwR2pHWXFSWEZrTlIyRitKV1NUeXh3VGtZdHUwYWwyQ2Jm?=
 =?utf-8?B?dFE9PQ==?=
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
	aiw12D2lM/5niqB8k9kzARG3FbMWBX0XtF1QO+hJIX9S9SDFMDXFp2i/uPZX/TUVjSe0+w95fMiqKpRpl5p0g3IwpeTJlPR+A+Y4OWUt51J0FUT7TYagN74bHJATg6n5I2tpXxfydciahpdBDK4I7f241/32gOwQv5AxZv+8I7MY1mQk+//+nYi7T0uOQkdNeh7mtzCnPhPosKyLY2FsiICZrrCnwocTSYo6nJ4vzuifynX2MFQdF/yXrK8vftM9pggo1PDbSzepnFLHRyYivHm7+x3+RbFCA0Xr95lkyipT+eNnlvZKzr9b/KH2lAbFA9kicPACksLUB2MBvzhiW1rDP2xctDx1j1Q8M8FyRgVtAGy5UJ/FOsQ3GFzudH6bOK7w6OkrhbWWhiUOCTesVYzRSnH+qk6Mtsb2IpT6JvbR/2r2ZEPVKPcR4pAxRwLtnOpewgiXYg6/hEKb0YoHxIXVPykUw9qT2lIY1416ypQ0eZbGl427JKrh3okgdpaPS1i9YVlBglrHIHRoPGHDNdDaotzTYhxaW30qw3+afp3IkqZ9HiCnOft+YLMjCughv0JbX7K1ozwsXc/l8uzj6cpwUoFcfVgmCmWWxg71lZ3Yb2usGznD4C4E8vdIOr7C
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR17MB2110.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1364a2-12f0-4950-4f73-08dc7ad036ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 02:29:47.2551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAVyiEgvvhYZmVX4IqyGRdyCGiWkNZjqIx8Getb9tNyKI96W7eJoKsO33MawTGw4kr9ncud+36AhAt5OEqmCISi+oqVwibP9WtpPlomBISU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR17MB7249
X-Proofpoint-ORIG-GUID: sN92evyf7bjbFQ_cx3VE9CqFZUAyBYWU
X-Proofpoint-GUID: sN92evyf7bjbFQ_cx3VE9CqFZUAyBYWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_14,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230016

PiBPbiBXZWQsIE1heSAyMiwgMjAyNCBhdCA4OjU04oCvUE0gVG9tIEhlcmJlcnQgPG1haWx0bzp0
b21Ac2lwYW5kYS5pbz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIE1heSAyMiwgMjAyNCBhdCA1
OjA54oCvUE0gQ2hyaXMgU29tbWVycw0KPiA+IDxtYWlsdG86Y2hyaXMuc29tbWVyc0BrZXlzaWdo
dC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gT24gV2VkLCBNYXkgMjIsIDIwMjQgYXQgNjox
OeKAr1BNIEpha3ViIEtpY2luc2tpIDxtYWlsdG86a3ViYUBrZXJuZWwub3JnPiB3cm90ZToNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IEhpIEphbWFsIQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gVHVl
LCAyMSBNYXkgMjAyNCAwODozNTowNyAtMDQwMCBKYW1hbCBIYWRpIFNhbGltIHdyb3RlOg0KPiA+
ID4gPiA+ID4gQXQgdGhhdCBwb2ludCh2MTYpIGkgYXNrZWQgZm9yIHRoZSBzZXJpZXMgdG8gYmUg
YXBwbGllZCBkZXNwaXRlIHRoZQ0KPiA+ID4gPiA+ID4gTmFja3MgYmVjYXVzZSwgZnJhbmtseSwg
dGhlIE5hY2tzIGhhdmUgbm8gbWVyaXQuIFBhb2xvIHdhcyBub3QNCj4gPiA+ID4gPiA+IGNvbWZv
cnRhYmxlIGFwcGx5aW5nIHBhdGNoZXMgd2l0aCBOYWNrcyBhbmQgdHJpZWQgdG8gbWVkaWF0ZS4g
SW4gaGlzDQo+ID4gPiA+ID4gPiBtZWRpYXRpb24gZWZmb3J0IGhlIGFza2VkIGlmIHdlIGNvdWxk
IHJlbW92ZSBlQlBGIC0gYW5kIG91ciBhbnN3ZXIgd2FzDQo+ID4gPiA+ID4gPiBubyBiZWNhdXNl
IGFmdGVyIGFsbCB0aGF0IHRpbWUgd2UgaGF2ZSBiZWNvbWUgZGVwZW5kZW50IG9uIGl0IGFuZA0K
PiA+ID4gPiA+ID4gZnJhbmtseSB0aGVyZSB3YXMgbm8gdGVjaG5pY2FsIHJlYXNvbiBub3QgdG8g
dXNlIGVCUEYuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJJ20gbm90IGZ1bGx5IGNsZWFyIG9uIHdo
byB5b3UncmUgYXBwZWFsaW5nIHRvLCBhbmQgSSBtYXkgYmUgbWlzc2luZw0KPiA+ID4gPiA+IHNv
bWUgcG9pbnRzLiBCdXQgbWF5YmUgaXQgd2lsbCBiZSBtb3JlIHVzZWZ1bCB0aGFuIGh1cnRmdWwg
aWYgSSBjbGFyaWZ5DQo+ID4gPiA+ID4gbXkgcG9pbnQgb2Ygdmlldy4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IEFGQUlVIEJQRiBmb2xrcyBkaXNhZ3JlZSB3aXRoIHRoZSB1c2Ugb2YgdGhlaXIgc3Vi
c3lzdGVtLCBhbmQgdGhleQ0KPiA+ID4gPiA+IHBvaW50IG91dCB0aGF0IFA0IHBpcGVsaW5lcyBj
YW4gYmUgaW1wbGVtZW50ZWQgdXNpbmcgQlBGIGluIHRoZSBmaXJzdA0KPiA+ID4gPiA+IHBsYWNl
Lg0KPiA+ID4gPiA+IFRvIHdoaWNoIHlvdSByZXBseSB0aGF0IHlvdSBsaWtlIChhIGhpZ2hseSBk
YXRlZCB0eXBlIG9mKSBhIG5ldGxpbmsNCj4gPiA+ID4gPiBpbnRlcmZhY2UsIGFuZCAoaGFuZHdh
dmV5KSBhYmlsaXR5IHRvIGNvbmZpZ3VyZSB0aGUgZGF0YSBwYXRoIFNXIG9yDQo+ID4gPiA+ID4g
SFcgdmlhIHRoZSBzYW1lIGludGVyZmFjZS4NCj4gPiA+ID4NCj4gPiA+ID4gSXQncyBub3Qgd2hh
dCBJICJsaWtlIiAsIHJhdGhlciBpdCBpcyBhIHJlcXVpcmVtZW50IHRvIHN1cHBvcnQgYm90aA0K
PiA+ID4gPiBzL3cgYW5kIGgvdyBvZmZsb2FkLiBUaGUgVEMgbW9kZWwgaXMgdGhlIHRyYWRpdGlv
bmFsIGFwcHJvYWNoIHRvDQo+ID4gPiA+IGRlcGxveSB0aGVzZSBtb2RlbHMuIEkgYWRkcmVzc2Vk
IHRoZSBzYW1lIGNvbW1lbnQgeW91IGFyZSBtYWtpbmcgYWJvdmUNCj4gPiA+ID4gaW4gIzFhIGFu
ZCAjMWIgwqAoaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2l0aHViLmNvbS9w
NHRjLWRldi9wdXNoYmFjay1wYXRjaGVzX187ISFJNXBWazRMSUdBZm52dyFrYVo2RW1QeEVxR0xH
OEpNdy1fTDBCZ1lxNDhQZTI1d2o2cEhNRjZCVmVpNVdzUmd3TWVMUXVwbXZndkx5Ti1MZ1hhY0tC
enpzMC13MnpLUDJBJCkuDQo+ID4+ID4NCj4gPiA+ID4gT1RPSCwgIkJQRiBmb2xrcyBkaXNhZ3Jl
ZSB3aXRoIHRoZSB1c2Ugb2YgdGhlaXIgc3Vic3lzdGVtIiBpcyBhDQo+ID4gPiA+IHByb2JsZW1h
dGljIHN0YXRlbWVudC4gSXMgQlBGIGluZnJhIGZvciB0aGUga2VybmVsIGNvbW11bml0eSBvciBp
cyBpdA0KPiA+ID4gPiBzb21ldGhpbmcgdGhlIGVicGYgZm9sa3MgY2FuIGRlY2lkZSwgYXQgdGhl
aXIgd2hpbSwgdG8gYWxsb3cgd2hvIHRoZXkNCj4gPiA+ID4gbGlrZSB0byB1c2Ugb3Igbm90LiBX
ZSBhcmUgbm90IGNoYW5naW5nIGFueSBCUEYgY29kZS4gQW5kIHRoZXJlJ3MNCj4gPiA+ID4gYWxy
ZWFkeSBhIGNhc2Ugd2hlcmUgdGhlIGludGVyZmFjZXMgYXJlIHVzZWQgZXhhY3RseSBhcyB3ZSB1
c2VkIHRoZW0NCj4gPiA+ID4gaW4gdGhlIGNvbm50cmFjayBjb2RlIGkgcG9pbnRlZCB0byBpbiB0
aGUgcGFnZSAod2UgbGl0ZXJhbGx5IGNvcGllZA0KPiA+ID4gPiB0aGF0IGNvZGUpLiBXaHkgaXMg
aXQgb2sgZm9yIGNvbm50cmFjayBjb2RlIHRvIHVzZSBleGFjdGx5IHRoZSBzYW1lDQo+ID4gPiA+
IGFwcHJvYWNoIGJ1dCBub3QgdXM/DQo+ID4gPiA+DQo+ID4gPiA+ID4gQUZBSUNUIHRoZXJlJ3Mg
c29tZSBidXQgbm90IHZlcnkgc3Ryb25nIHN1cHBvcnQgZm9yIFA0VEMsDQo+ID4gPiA+DQo+ID4g
PiA+IEkgZG9udCBhZ3JlZS4gUGFvbG8gYXNrZWQgdGhpcyBxdWVzdGlvbiBhbmQgYWZhaWsgSW50
ZWwsIEFNRCAoYm90aA0KPiA+ID4gPiBidWlsZCBQNC1uYXRpdmUgTklDcykgYW5kIHRoZSBmb2xr
cyBpbnRlcmVzdGVkIGluIHRoZSBNUyBEQVNIIHByb2plY3QNCj4gPiA+ID4gcmVzcG9uZGVkIHNh
eWluZyB0aGV5IGFyZSBpbiBzdXBwb3J0LiBMb29rIGF0IHdobyBpcyBiZWluZyBDY2VkLiBBIGxv
dA0KPiA+ID4gPiBvZiB0aGVzZSBmb2xrcyB3aG8gYXR0ZW5kIGJpd2Vla2x5IGRpc2N1c3Npb24g
Y2FsbHMgb24gUDRUQy4gU2FtcGxlOg0KPiA+ID4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L0lBMFBSMTdNQjcwNzBCNTFBOTU1RkI4
NTk1RkZCQTVGQjk2NUUyQElBMFBSMTdNQjcwNzAubmFtcHJkMTcucHJvZC5vdXRsb29rLmNvbS9f
XzshIUk1cFZrNExJR0FmbnZ3IWthWjZFbVB4RXFHTEc4Sk13LV9MMEJnWXE0OFBlMjV3ajZwSE1G
NkJWZWk1V3NSZ3dNZUxRdXBtdmd2THlOLUxnWGFjS0J6enMwOVRGem9RQnckDQo+ID4+ID4NCj4g
PiA+ICsxDQo+ID4gPiA+ID4gYW5kIGl0DQo+ID4gPiA+ID4gZG9lc24ndCBiZW5lZml0IG9yIHNv
bHZlIGFueSBwcm9ibGVtcyBvZiB0aGUgYnJvYWRlciBuZXR3b3JraW5nIHN0YWNrDQo+ID4gPiA+
ID4gKGUuZy4gZXhwcmVzc2luZyBvciBjb25maWd1cmluZyBwYXJzZXIgZ3JhcGhzIGluIGdlbmVy
YWwpDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBIdWg/IEFzIGEgRFNMLCBQNCBo
YXMgYWxyZWFkeSBiZWVuIHByb3ZlbiB0byBiZSBhbiBleHRyZW1lbHkgZWZmZWN0aXZlIGFuZCBw
b3B1bGFyIHdheSB0byBleHByZXNzIHBhcnNlIGdyYXBocywgc3RhY2sgbWFuaXB1bGF0aW9uLCBh
bmQgc3RhdGVmdWwgcHJvZ3JhbW1pbmcuIFllc3RlcmRheSwgSSB1c2VkIHRoZSBQNFRDIGRldiBi
cmFuY2ggdG8gaW1wbGVtZW50IHNvbWV0aGluZyBpbiBvbmUgc2l0dGluZywgd2hpY2ggaW5jbHVk
ZXMgcGFyc2luZyBSb0NFdjIgbmV0d29yayBzdGFja3MuIEkganVzdCBjdXQgYW5kIHBhc3RlZCBQ
NCBjb2RlIG9yaWdpbmFsbHkgd3JpdHRlbiBmb3IgYSBQNCBBU0lDIGludG8gYSB3b3JraW5nIFA0
VEMgZXhhbXBsZSB0byBhZGQgZnVuY3Rpb25hbGl0eS4gSXQgdG9vayBtZXJlIHNlY29uZHMgdG8g
Y29tcGlsZSBhbmQgbGF1bmNoIGl0LCBhbmQgYSBmZXcgbWludXRlcyB0byB0ZXN0IGl0LiBJIGtu
b3cgb2Ygbm8gb3RoZXIgd29ya2Zsb3cgd2hpY2ggcHJvdmlkZXMgc3VjaCBxdWljayB0dXJuYXJv
dW5kIGFuZCBpcyBzbyBhY2Nlc3NpYmxlLiBJJ2QgbGlrZSBpdCB0byBiZSBhcyB1YmlxdWl0b3Vz
IGFzIGVCUEYgaXRzZWxmLg0KPiA+DQo+ID4gQ2hyaXMsDQo+ID4NCj4gPiBXaGVuIHlvdSBzYXkg
Iml0IHRvb2sgbWVyZSBzZWNvbmRzIHRvIGNvbXBpbGUgYW5kIGxhdW5jaCIgYXJlIHlvdQ0KPiA+
IHRha2luZyBpbnRvIGFjY291bnQgdGhlIHJhbXAgdXAgdGltZSB0aGF0IGl0IHRha2VzIHRvIGxl
YXJuIFA0IGFuZA0KPiA+IGJlY29tZSBwcm9maWNpZW50IHRvIGRvIHNvbWV0aGluZyBpbnRlcmVz
dGluZz8gDQoNCkhpIFRvbSwgdGhhbmtzIGZvciB0aGUgZGlhbG9nLiBUbyBhbnN3ZXIgeW91ciBx
dWVzdGlvbiwgaXQgdG9vayBzZWNvbmRzIHRvIGNvbXBpbGUgYW5kIGRlcGxveSwgbm90IGxlYXJu
IFA0LiBBZGRpbmcgdGhlIHBhcnNpbmcgZm9yIHNldmVyYWwgaGVhZGVycyB0b29rIG1pbnV0ZXMu
IElmIHlvdSB3YW50IHRvIGNvbXBhcmUgbGVhcm5pbmcgY3VydmUsIGxlYXJuaW5nIHRvIHdyaXRl
IFA0IGNvZGUgYW5kIGxldCB0aGUgZnJhbWV3b3JrIGhhbmRsZSBhbGwgdGhlIHBhaW5mdWwgbG93
LWxldmVsIExpbnV4IGRldGFpbHMgaXMgd2F5IGVhc2llciB0aGFuIHRyeWluZyB0byBsZWFybiBo
b3cgdG8gd3JpdGUgYyBjb2RlIGZvciBMaW51eCBuZXR3b3JraW5nLiBJdOKAmXMgbm90IGV2ZW4g
Y2xvc2UuIEnigJl2ZSB3cml0dGVuIEMgZm9yIDQwIHllYXJzLCBQNCBmb3IgNyB5ZWFycywgYW5k
IGRhYmJsZWQgaW4gZUJQRiBzbyBJIGNhbiBhdHRlc3QgdG8gdGhlIGVhc2Ugb2YgbGVhcm5pbmcg
YW5kIHVzaW5nIFA0LiBJ4oCZdmUgb25ib2FyZGVkIGFuZCBtZW50b3JlZCBlbmdpbmVlcnMgd2hv
IGJhcmVseSBrbmV3IEMsIHRvIGRldmVsb3AgY29tcGxleCBuZXR3b3JraW5nIHByb2R1Y3RzIHVz
aW5nIFA0LCBhbmQgYnVpbHQgdGhlIGF1dG9tYXRpb24gQVBJcyAoUkVTVCwgZ1JQQykgdG8gbWFu
YWdlIHRoZW0uIE9uZSBwZXJzb24gY2FuIGRldmVsb3AgYW4gZW50aXJlIGNvbW1lcmNpYWwgcHJv
ZHVjdCBieSB0aGVtc2VsdmVzIGluIG1vbnRocy4gUDQgaGFzIGV4cGFuZGVkIHRoZSByZWFjaCBv
ZiBwcm9ncmFtbWVycyBzdWNoIHRoYXQgYm90aCBIVyBhbmQgU1cgZW5naW5lZXJzIGNhbiBlYXNp
bHkgbGVhcm4gUDQgYW5kIGJlY29tZSBwcmV0dHkgYWRlcHQgYXQgaXQuIEkgd291bGQgbm90IGV4
cGVjdCBldmVuIGV4cGVyaWVuY2VkIGMgcHJvZ3JhbW1lcnMgdG8gYmUgYWJsZSB0byBtYXN0ZXIg
TGludXggaW50ZXJuYWxzIHZlcnkgcXVpY2tseS4gV3JpdGluZyBhIFA0LVRDIHByb2dyYW0gYW5k
IGluamVjdGluZyBpdCB2aWEgdGMgd2FzIGxpa2UgbWFnaWMgdGhlIGZpcnN0IHRpbWUuDQoNCj4+
IENvbnNpZGVyaW5nIHRoYXQgUDQNCj4gPiBzeW50YXggaXMgdmVyeSBkaWZmZXJlbnQgZnJvbSB0
eXBpY2FsIGxhbmd1YWdlcyB0aGFuIG5ldHdvcmtpbmcNCj4gPiBwcm9ncmFtbWVycyBhcmUgdHlw
aWNhbGx5IGZhbWlsaWFyIHdpdGgsIHRoaXMgcmFtcCB1cCB0aW1lIGlzDQo+ID4gbm9uLXplcm8u
IE9UT0gsIGVCUEYgaXMgdWJpcXVpdG91cyBiZWNhdXNlIGl0J3MgcHJpbWFyaWx5IHByb2dyYW1t
ZWQNCj4gPiBpbiBSZXN0cmljdGVkIEMtLSB0aGlzIG1ha2VzIGl0IGVhc3kgZm9yIG1hbnkgcHJv
Z3JhbW1lcnMgc2luY2UgdGhleQ0KPiA+IGRvbid0IGhhdmUgdG8gbGVhcm4gYSBjb21wbGV0ZWx5
IG5ldyBsYW5ndWFnZSBhbmQgc28gdGhlIHJhbXAgdXAgdGltZQ0KPiA+IGZvciB0aGUgYXZlcmFn
ZSBuZXR3b3JraW5nIHByb2dyYW1tZXIgaXMgbXVjaCBsZXNzIGZvciB1c2luZyBlQlBGLg0KDQpJ
IHRoaW5rIHlvdXIgc3RhdGVtZW50IGFib3V0IOKAnHR5cGljYWwgbmV0d29yayBwcm9ncmFtbWVy
c+KAnSBvdmVybG9va3MgdGhlIGZhY3QgdGhhdCBzaW5jZSBQNCB3YXMgaW50cm9kdWNlZCwgaXQg
aGFzIGJlZW4gdGF1Z2h0IGluIG1hbnkgdW5pdmVyc2l0aWVzIHRvIHRlYWNoIG5ldHdvcmtpbmcg
YW5kIHBvc3NpYmx5IGVuYWJsZWQgYSB3aG9sZSBuZXcgYnJlZWQgb2Yg4oCcbmV0d29yayBlbmdp
bmVlcnPigJ0gd2hvIGNhbiBzb2x2ZSByZWFsIHByb2JsZW1zIHdpdGhvdXQgZXZlbiBrbm93aW5n
IEMgcHJvZ3JhbW1pbmcuIFdpdGhvdXQgUDQgdGhleSBtaWdodCBuZXZlciBoYXZlIGdvbmUgdGhp
cyByb3V0ZS4gQSBjbGFzcyBpbiBuZXR3b3JrIHN0YWNrIHByb2dyYW1taW5nIHVzaW5nIGMgd291
bGQgaGF2ZSBzbyBtYW55IHByZXJlcXVpc2l0ZXMgdG8gZXZlbiBnZXQgdG8gcGFyc2luZywgY29t
cGFyZWQgdG8gUDQsIHdoZXJlIGl0IGNvdWxkIGJlIGRlbW9uc3RyYXRlZCBpbiBvbmUgbGVzc29u
LiBUaGVzZSDigJxuZXR3b3JraW5nIHByb2dyYW1tZXJz4oCdIGFyZSBub3QgdHlwaWNhbCBieSB5
b3VyIHN0YW5kYXJkcywgYnV0IHRoZXJlIGFyZSBtYW55IHN1Y2guIFRoZXkgaGF2ZSBqdXN0IGFz
IG11Y2ggY2xhaW0gdG8gdGhlIHRpdGxlICJuZXR3b3JrIHByb2dyYW1tZXLigJ0gYXMgYSBDIHBy
b2dyYW1tZXIuIFNpbWlsYXJseSwgYW4gYXNzZW1ibHkgbGFuZ3VhZ2UgcHJvZ3JhbW1lciBpcyBu
byBsZXNzIHRoYW4gYSBDIG9yIFB5dGhvbiBwcm9ncmFtbWVyLiBQZW9wbGUgd3JpdGluZyBQNCBh
cmUgdXN1YWxseSBmb2N1c2VkIG9uIGFwcGxpY2F0aW9ucywgYW5kIGl0IGlzIHZlcnkgdXNlZnVs
IGFuZCBwcm9kdWN0aXZlIGZvciB0aGF0LiBXaHkgc2hvdWxkIHNvbWVvbmUgaGF2ZSB0byBsZWFy
biBsb3ctbGV2ZWwgQyBvciBlQlBGIHRvIHNvbHZlIHRoZWlyIHByb2JsZW0/DQoNCj4gPg0KPiA+
IFRoaXMgaXMgcmVhbGx5IHRoZSBmdW5kYW1lbnRhbCBwcm9ibGVtIHdpdGggRFNMcywgdGhleSBy
ZXF1aXJlDQo+ID4gc3BlY2lhbGl6ZWQgc2tpbGwgc2V0cyBpbiBhIHByb2dyYW1taW5nIGxhbmd1
YWdlIGZvciBhIG5hcnJvdyB1c2UgY2FzZQ0KPiA+IChhbmQgc3BlY2lhbGl6ZWQgY29tcGlsZXJz
LCB0b29sIGNoYWlucywgZGVidWdnaW5nLCBldGMpLS0gdGhpcyBtZWFucw0KPiA+IGEgRFNMIG9u
bHkgbWFrZXMgc2Vuc2UgaWYgdGhlcmUgaXMgbm8gb3RoZXIgbWVhbnMgdG8gYWNjb21wbGlzaCB0
aGUNCj4gPiBzYW1lIGVmZmVjdHMgdXNpbmcgYSBjb21tb2RpdHkgbGFuZ3VhZ2Ugd2l0aCBwZXJo
YXBzIGEgc3BlY2lhbGl6ZWQNCj4gPiBsaWJyYXJ5IChpdCdzIG5vdCBqdXN0IGluIHRoZSBuZXR3
b3JraW5nIHJlYWxtLCBjb25zaWRlciB0aGUNCj4gPiBhZHZhbnRhZ2VzIG9mIHVzaW5nIENVREEt
QyBpbnN0ZWFkIG9mIGEgRExTIGZvciBHUFVzKS4NCg0KQSBwcmV0dHkgc3Ryb25nIG9waW5pb24s
IGJ1dCBEU0xzIGFyaXNlIHRvIGZpbGwgYSBuZWVkIGFuZCBQNCBkaWQgc28uIEl0J3Mgc3RpbGwg
Z29pbmcgc3Ryb25nLg0KDQo+PiBQZXJzb25hbGx5LCBJDQo+ID4gZG9uJ3QgYmVsaWV2ZSB0aGF0
IFA0IGhhcyB5ZXQgdG8gYmUgcHJvdmVuIG5lY2Vzc2FyeSBmb3IgcHJvZ3JhbW1pbmcgYQ0KPiA+
IGRhdGFwYXRoLS0gZm9yIGluc3RhbmNlIHdlIGNhbiBwcm9ncmFtIGEgcGFyc2VyIGluIGRlY2xh
cmF0aXZlDQo+ID4gcmVwcmVzZW50YXRpb24gaW4gQywNCj4gPiBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9uZXRkZXZjb25mLmluZm8vMHgxNi9wYXBlcnMvMTEvSGlnaCoyMFBl
cmZvcm1hbmNlKjIwUHJvZ3JhbW1hYmxlKjIwUGFyc2Vycy5wZGZfXztKU1VsISFJNXBWazRMSUdB
Zm52dyFtOXpyU0R2ZGRmelN0X3NNQmpPRXZxdzMxUnpBd1dsRURNNGFoNUlKMmtxc21xNlh0UElW
SmQtMV9ab0dXQlhLTHlkYTc3UllMdkdSODNHaW53JC4NCg0KQ1BMIChzbGlkZTExKSBsb29rcyBs
aWtlIGEgRFNMIHdyYXBwZWQgaW4gSlNPTiB0byBtZS4g4oCcU29sdXRpb246IENvbW1vbiBQYXJz
ZXIgTGFuZ3VhZ2UgKENQTCk7IFBhcnNlciByZXByZXNlbnRhdGlvbiBpbiBkZWNsYXJhdGl2ZSAu
anNvbuKAnSBTbyBJIGFtIGNvbmZ1c2VkLiBJdCBpcyBlaXRoZXIgYSBuZXcgbGFuZ3VhZ2UgYS5r
LmEuIERTTCwgb3IgaXQncyBub3QuIE5vdGhpbmcgYWdhaW5zdCBpdCwgSSdtIHN1cmUgaXQgaXMg
Z3JlYXQsIGJ1dCBsZXQncyBjYWxsIGl0IHdoYXQgaXQgaXMuDQpXZSBhbHJlYWR5IGhhdmUgcGFy
c2VyIHJlcHJlc2VudGF0aW9ucyBpbiBkZWNsYXJhdGl2ZSBwNC4gQW5kIGl0J3MgdXNlZCBhbmQg
a25vd24gd29ybGR3aWRlLiBBbmQgaGFzIGEgcmVzcGVjdGFibGUgc3BlY2lmaWNhdGlvbiwgYW55
IHVzZXJzIGFuZCB3b3JraW5nIGdyb3Vwcy4gQW5kIGl0J3MgZm9ybWFsbHkgcHJvdmFibGUgKGh0
dHBzOi8vZ2l0aHViLmNvbS92ZXJpZmllZC1uZXR3b3JrLXRvb2xjaGFpbi9wZXRyNCkNCg0KPiA+
DQo+ID4gU28gdW5sZXNzIFA0IGlzIHByb3ZlbiBuZWNlc3NhcnksIHRoZW4gSSdtIGRvdWJ0ZnVs
IGl0IHdpbGwgZXZlciBiZSBhDQo+ID4gdWJpcXVpdG91cyB3YXkgdG8gcHJvZ3JhbSB0aGUga2Vy
bmVsLS0gaXQgc2VlbXMgbXVjaCBtb3JlIGxpa2VseSB0aGF0DQo+ID4gcGVvcGxlIHdpbGwgY29u
dGludWUgdG8gdXNlIEMgYW5kIGVCUEYsIGFuZCBmb3IgdGhvc2UgdXNlcnMgdGhhdCB3YW50DQo+
ID4gdG8gdXNlIFA0IHRoZXkgY2FuIHVzZSBQNC0+ZUJQRiBjb21waWxlci4NCg0K4oCcdWJpcXVp
dG91cyB3YXkgdG8gcHJvZ3JhbSB0aGUga2VybmVs4oCdIOKAkyBpcyBub3QgbXkgZ29hbC4gSSBk
b27igJl0IGV2ZW4gd2FudCB0byBrbm93IGFib3V0IHRoZSBrZXJuZWwgd2hlbiBJIGFtIHdyaXRp
bmcgcDQgLSBpdCdzIGp1c3QgYSBtZWFucyB0byBhbiBlbmQuIEkgd2FudCB0byBtYW5pcHVsYXRl
IHBhY2tldHMgb24gYSBMaW51eCBob3N0LiBQNERQREssIFA0LWVCUEYsIFA0LVRDIOKAkyBhbGwg
bGV0IG1lIGRvIHRoYXQuIEkgTE9WRSB0aGUgZmFjdCB0aGF0IFA0LVRDIHdvdWxkIGJlIGF2YWls
YWJsZSBpbiBldmVyeSBMaW51eCBkaXN0cm8gb25jZSB1cHN0cmVhbWVkLiBJdCB3b3VsZCBzb2x2
ZSBzbyBtYW55IGRlcGxveW1lbnQgaXNzdWVzLCBiZW5lZml0IGZyb20gcmVncmVzc2lvbiB0ZXN0
aW5nLCBldGMuIFNvIG11Y2ggZ29vZG5lc3MuDQoNCiIgYW5kIGZvciB0aG9zZSB1c2VycyB0aGF0
IHdhbnQgdG8gdXNlIFA0IHRoZXkgY2FuIHVzZSBQNC0+ZUJQRiBjb21waWxlci4iIC1JJ2QgcmVh
bGx5IGxpa2UgdG8gY2hvb3NlIGZvciBteXNlbGYgYW5kIG5vdCBoYXZlIHNvbWVvbmUgbWFrZSB0
aGF0IGNob2ljZSBmb3IgbWUuIFA0LVRDIGNoZWNrcyBhbGwgdGhlIGJveGVzIGZvciBtZS4NCg0K
VGhhbmtzIGZvciB0aGUgcG9pbnQgb2YgdmlldywgaXQncyBoZWFsdGh5IHRvIGRlYmF0ZS4NCkNo
ZWVycywNCkNocmlzDQoNCj4gPg0KPsKgDQo+IFRvbSwNCj4gSSBjYW50IHN0b3AgdGhlIGRpc3Ry
YWN0aW9uIG9mIHRoaXMgdGhyZWFkIGJlY29taW5nIGEgZGlzY3Vzc2lvbiBvbg0KPiB0aGUgbWVy
aXRzIG9mIERTTCB2cyBhIGxvd2VyIGxldmVsIGxhbmd1YWdlIChhbmQgSSBrbm93IHlvdSBhcmUg
bm90IGENCj4gUDQgZmFuKSBidXQgcGxlYXNlIGNoYW5nZSB0aGUgc3ViamVjdCBzbyB3ZSBkb250
IGxvb3NlIHRoZSBtYWluIGZvY3VzDQo+IHdoaWNoIGlzIGEgZGlzY3Vzc2lvbiBvbiB0aGUgcGF0
Y2hlcy4gSSBoYXZlIGRvbmUgaXQgZm9yIHlvdS4gQ2hyaXMgaWYNCj4geW91IHdpc2ggdG8gcmVz
cG9uZCBwbGVhc2UgcmVzcG9uZCB1bmRlciB0aGUgbmV3IHRocmVhZCBzdWJqZWN0Lg0KPsKgDQo+
IGNoZWVycywNCj4gamFtYWwNCg0K

