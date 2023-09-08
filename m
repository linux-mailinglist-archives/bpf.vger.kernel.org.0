Return-Path: <bpf+bounces-9500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D59F79881F
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DF0281A10
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B87963B3;
	Fri,  8 Sep 2023 13:50:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812753B4
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:50:18 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C021FED;
	Fri,  8 Sep 2023 06:49:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388DlRE8002156;
	Fri, 8 Sep 2023 13:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vEDSUEj/UAjcg61071vZbawmaIKNOmoldh2fZHALrH4=;
 b=1aOO1Vy9kssxne47VMOr01CEHHyUuiY9OnqO1kHsdqlUK6fApz3SYU27qHEeeZRh9PlV
 peNkJHGjGZoajx4YsL7QmdE8uCmJWydYlPJQ8u06zCZKfGalzPQny8AzQkJrL3vpTdO4
 l5xlL0aLaUapjtWWnfE78RtGhBeH1LMBQUmLR9UOfCUi5WdBbRW07W/yec0G8HlCAOGX
 isdRTg7oU+BuvCtx4bQn4hhrCRbaFtkFwvc9pcnhFkzFqAj0tHZjwoyBbST9rvSFHrqv
 nx6NBp8evd+LtcKchYMOxrX/NXBd4KSzVdT46IX82lvHK3riTE2u2Hu11bkAGuy1zIJu sQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t04sjr0d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Sep 2023 13:49:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388CgkS4017258;
	Fri, 8 Sep 2023 13:49:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug9nsge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Sep 2023 13:49:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvAYS44W6ogpC+iQlVG1f1Mql5sXNhfjbJD4HlisECI5CX3Gw0DspKynPLgMr/rDvDB/QlAVI7oUMQo1B7dbIW0iN+3X7StcSV2uDve/ZVpOQFZQ+bErn+7sPBDECPOiriITSg04Q7O3P3GykUY+zXd8EQM6wDJSjONCp62oFDJBKQbrBqBhDtqV/vyu9/8eC0Kics5KRGBzsgcBg8sEC2b/1CklTFxZ6PY9X8GlyC1pRHVk9Mm9amdOI4r0NChEe4exdQrjAh4vTT6PDGnBAvejvuFpGNq1QcFtbvIxZYBtY388SE7uCmMlRe+Xk3/wpCVyU3VFiHpDIkIYRFrcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEDSUEj/UAjcg61071vZbawmaIKNOmoldh2fZHALrH4=;
 b=Vrsq2llyffdrbBkPcas+98HwzBwMJ2rkPZdFLUXLVaKcMe1k9HiKaRRbXjIYDcA8/k3S9f5RvPjO+a/0AQGQt1WI0htu/Wt3cVXxJKBTLJSzwNMA5bOvesUh0iObgqGVJle0aSbJvcRd54tswX0FvEos8tHoLhwgnAxco5OZR+dYBnnIC6Ekab8bW6LAw4jLlk7wOWkpQHTcgd3zycrs5RB8UzqvArOqewZF6TekWbNSeC4vhb72+BZOlIWmmY6AGd3bQA1hrTyJNzG5owPIj213BH1Hctmas+NQKWi4ci/KelSxAWj4fGWB/LrZOOnhCZWn6FuxSP6wzotOAzciLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEDSUEj/UAjcg61071vZbawmaIKNOmoldh2fZHALrH4=;
 b=AKbd/iSF9E5plkXH9/8r6rzJ5ZCQmNUcIEXRzUIRSYXSqx8qIEU5ELewlEAvHZxFiEJW9Kvm/spFwKbJTZPvH8Txkr0zL7SHxZlhHxW5M4RV4rLb3s57p6AoGtB1SonH69Pq90GXzn671nIbslvBFFL/ATvtol2N/9oFIszTvSE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6996.namprd10.prod.outlook.com (2603:10b6:8:152::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 13:49:03 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7ae6:dcdd:3e38:5829]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7ae6:dcdd:3e38:5829%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 13:49:03 +0000
Message-ID: <2deafa8c-94cb-247a-2a8f-97f756f28898@oracle.com>
Date: Fri, 8 Sep 2023 14:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf 1/2] bpf: Add override check to kprobe multi link
 attach
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Djalal Harouni <tixxdz@gmail.com>
References: <20230907200652.926951-1-jolsa@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230907200652.926951-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0094.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: e74ab3a0-ab0b-4065-5c40-08dbb0725d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kyp6UKYhXlL1SKrOL0+OoO42uGkJAJPiaaUz4dSnhc1J8/T5JOUNTb8uX1KqAqz/sF2p5qSpCuGqqyWf9iDh6+DS1iABGrqNjbwGgs/egFbDYxn/kll2Pu1HiAsQtisox1ayAIHC1n+6AYoT20x4mfGrhQKRcPzNiAY/Rj+L7iJzKt1kUylNsaP3f/5Qiv7MZHJjBktO8LpV77PaDosSntAkjbz9FTKqAFPxdaJD/OVGm5ccsU8RKu7kZUlbptPD7yPgqJdwJl/fmygmKgSgk1CbkMJPwk8I9kheOAnLh3s30Hhtl/Cp3fXBzjZ7Po+Tsb8+WGCD7RZ/vjvTAGYGD0wDOIePC5hkqbBBnzs7qz/OVk8oqR/Z/IVP429ZeZcM5dH+Y4NhsVn12mw3ek7sCE1N7edHqm+s3o6sXfDeHvfUokBx9qqCqPkPw2r81zuZRPp1wESuhAEON3Nc6doisictu6HlcnR1T/B2PhCyED3MOAyzliihymoE8kaam3Lpq7vfFIhSpXouh6kihK6XB4OjZ+cpCtc6R6lOnYT7kPZEXXb7u2W9z4mtgutcxFP8x7CK3qaIgTmh8k2qk6mG3igbFqqi/bbar9WnzipUbNxxSfvcFoUrdoOgjQ8DPABwwxTB2jqoi2ldZU5CNBuU/w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(1800799009)(186009)(451199024)(6486002)(6666004)(6506007)(53546011)(6512007)(478600001)(41300700001)(83380400001)(2616005)(7416002)(2906002)(66946007)(44832011)(66476007)(316002)(54906003)(66556008)(4326008)(110136005)(5660300002)(8936002)(8676002)(86362001)(36756003)(31696002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHo3KzV4ZHhwcVBhc3R1K0ZuOGViNGcwazB5WXRURmFWejdiVzFzNkE0bHdn?=
 =?utf-8?B?WXhSWHA1SXJlTFBNamlpczZRSmY3bUVPM3h4YTE2ZHpNSzZlVDBVMG9tT3pD?=
 =?utf-8?B?WEpWckV6dk9MTHdDYkFuM3Z2eUZBbStKSHk3R1I5K1RMdTc4WjFJWXVKTHRr?=
 =?utf-8?B?aFNJODdTR1pRWWcvRm5OSHFvU1JIVDRSUndheXpJZXJSSGVoSFkzQ2R3RnNN?=
 =?utf-8?B?NFZaUXN1VDlXeTFyLzFuYnc3VEVKWEhET2xueGFyT3hsTmNHL3Vob01LVFBm?=
 =?utf-8?B?R2t5MzBpeGs3cnZOVTRuWURPVysvWjVxMWxQSGRWb2t6b2w5OVdvemtCT0pQ?=
 =?utf-8?B?NHFtWWQrK2VkbzhIWnN3bEw3c0czVk1NMFUzS1lXOFNHNXBSVm9JdHNmeElh?=
 =?utf-8?B?b2JTUlVtay9Db1ViL1U1bmR4c05oTGRSQjgwZ0ZLNkpkVGVNUEhLNTVVRmxU?=
 =?utf-8?B?NlFrQmhVbHM3OXFiWEwrK29FZmdUN3NjSHk2ZnVKOFExaGdRYmNZTzNmWW5Z?=
 =?utf-8?B?MEszaythZXAzdUw0S0FrVWtUSVk3NkRzWU1pT05uU29ZRWhwNEh1SXIrTFI5?=
 =?utf-8?B?U1dVcEJqQXRhZURKcm5rMG9UN2o5ZWhBK0tjdElDN1ZpMS84cHhtSnBzYUNZ?=
 =?utf-8?B?RmxLRC81b2puU05hajczME9QZFlESUV3NmNJQXkyMHFad2hkVHNvZVVMVjNQ?=
 =?utf-8?B?Wjd1ZXVKaFFITHBkdktQVnM5Q05qTVlqSThSLzhSNHpHakVHOHQ3Sm5laHJ4?=
 =?utf-8?B?dXp3QnRYT2UyUTZkRkQ1Rlc2RlUvQXZ3VlVwMVNoeWhIZlZFK3RwK3V6aUVF?=
 =?utf-8?B?YXhaRFVib09GcUFOMnNmalkyNSs0OFg3dUxWZmNUUDNwYkRNSlg2c1lqNHhF?=
 =?utf-8?B?SkVaYVRRaldHV1VINFY5S1ZOTlNoVURBbWs1RnBvd2I4VWpmM25OekpLcDgy?=
 =?utf-8?B?aWd0RHpFc2tFTldOck1id0RnSUVycnR2RFc5SHh0ell4MS8yMHg3UDg4MHo3?=
 =?utf-8?B?aGJEZFdSMWVLTStGYmpkY3lmaFErNmhCQ3BUK3gzbERMVWwxcGRTY0FpZEwv?=
 =?utf-8?B?R0hnMmVHYm10QlN2ZjdxenB6UnNFeWI4MjB2NTB6U0llSDNVNzFpV1ZFa0Np?=
 =?utf-8?B?U21TS1dmZXk3UWNOeG1MYnRJdmM5YmNrOHNJdjQ1cFBucHZYUjNBU1J5S3FU?=
 =?utf-8?B?OUtYSmpIVTJLcnU4MkZ3OTVmcFpiWFlqOEFSQ00zUHFQUmg5TVp0dEpxR1F1?=
 =?utf-8?B?UDNmWnRmbDRuTmRiNGc5SEpqenBnbjB4SjdZTDlVQ0M1aGxhcTh2NmQwbTJx?=
 =?utf-8?B?dFMxaWlURDBia3h2bkxJRnpMc3hsMHZvRXNWNEMxQ2dWcXU1RGs1TndRWEZj?=
 =?utf-8?B?OWtQZFRhZEFWNkpKYjVWajZoWUZVMVdZMEtTMldlOXFXVmQvWStSYWxKdzA2?=
 =?utf-8?B?dWpmdDdjZUJvMGdZVmRqM2hIWXB0MGZXZUkxaWdQUTBJWnBoZml0WTBKcmRq?=
 =?utf-8?B?QVJTNk1PbWVKeHR3TEk4ajV4Nm93Mjh3QzUzYU9OZi9tOXJxTzZHOGMzMlNG?=
 =?utf-8?B?aTJGMXQ0WE11L2tKQWdGd2Irb0lGcm5IbndVaUFHWnI2aTkrNjdYR3o2TFlQ?=
 =?utf-8?B?QU9iS2lnVE1ZVkE5c0RQSW1GTDhVQzEzK2JhRnZZZWYwQzBMMUV3MFp3TWh0?=
 =?utf-8?B?SkJmVzEvTk84WDJqKzlvTi9UT2I2ejNuMUpXYXh0OWZRdmZ3VXdFVHk2czI1?=
 =?utf-8?B?ejZvQzM0L3IrWmZyV25kZm8vV0MrMUgvcGRYTzZPUnJ3V0p0VnllSU04UURX?=
 =?utf-8?B?VjFUYytKaVdyQ2ZNS3cwbEROOXNWdWo1blE2NWtYdkd3QkFzR1BQNFZPbTNt?=
 =?utf-8?B?dmMrams5SFMxK1pBUWlHYk5PQzIzVVZzZzNDcHFBVGNHVndiajFHMEEzU2dw?=
 =?utf-8?B?N0czVVU2RmRwTm1XUXpPcFprcXlXUklvYlB1T21DWlh1Wm1Hc3VicldvWTI4?=
 =?utf-8?B?OTlRQzlEd2docDJqN1RBU1QwZi9nbTR1RlVpMEJyeE9UNWVFRlcrQjNVRVRS?=
 =?utf-8?B?SXZPRFJZOXFWeTNFMDJOSitwNGt4ZTVnRk5ab3hYY0VLVmVQNWRiME5EV3B2?=
 =?utf-8?B?YURZWTBEYkE4TmY1bEJUNUVEUnk4V20xVyttdk8zTXdPSFZ3VTJodGpPaFlp?=
 =?utf-8?Q?1HaJ8Eh/gfxuV0LODMkQLIE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?Q0UvVDgvbkt0blJ0bHRONm4rWmZBL21XMFFFR2FDRmxNakU2R2NUQzNXdmtV?=
 =?utf-8?B?TWFCWjdkQ3NGWFU0T3FvemFNTWF2N1o3bTJqWGRkSHEyemtnYlFFM0FadXNm?=
 =?utf-8?B?Rm8yRnYvSk5zbmZoTmpDQTdyMDVCQXdsaTJ1QkF4dEVmU2hlSUlwN0lieEM4?=
 =?utf-8?B?eVR2YlVrcXYwWlZYUjJFcHdyVjIzUHdrQ294cHRiNTh3ZDVjTVNTUHRCbnJy?=
 =?utf-8?B?TGdxb3dEMGUvNkswVUlZQ3krMkcvbi9ZcElNdXptK0kyZDRUa3V2SkF2RmZi?=
 =?utf-8?B?bjBHRFFrZlNCUHNBT29FdlNmY1BzSGl0bWlSTjRkd2lnTzQvZXM4RWw1SlJq?=
 =?utf-8?B?amZuTTlXa0RoUzR2akVNVmppOHAvMlY5K3ArSUg4QW1uckwxcDNTczY0eWlR?=
 =?utf-8?B?OGZnak9VcWpMbFM3YzVLT0dFVnYycGNTTEtxcS94N1d2MVdPd0RFamxHb0Nz?=
 =?utf-8?B?cURJaGw1aGJxOHEzYkJ2UHlKVk1rTUhPQUVxZ01XUkJRL2p3N1BSS3RSdkla?=
 =?utf-8?B?bzA4R2RUZjhSN2gzMlB5YXI4RmYzOTBLV1czcXBWZkczd0VQKzE3UEE3Z01t?=
 =?utf-8?B?N3FwTEtXNFBZT2syR3JtcFBETW44VldNOWFlODdLTzZJSkczcTBlakVEVzVM?=
 =?utf-8?B?VGdQZFVNSmZQYmxRV1dmcVpjRW9YdnlzV2VnMk1odjRXcVltdWRSdGZIb2l4?=
 =?utf-8?B?b2RvSUtMemdRbUVVSmhDazAveWljczFWUzkxMC83M0FSRnRpYzlPV08vWVRD?=
 =?utf-8?B?MFJ4NFN5L1krYy81bXpnMDlKdjhjN1l3aWo4eURzNUwzMkZZOHpRbFMvVzAr?=
 =?utf-8?B?amFoNVV2d1pPYjVIdzFVVmUrc055czBqTlVmT1QrUk0xeno5SU1idjF6eHRJ?=
 =?utf-8?B?cWlhVVVhN092Q29FZVdaRGhZaVB4WGVzRFBVdGF5aXlwcUdXNUlEREhyMUpQ?=
 =?utf-8?B?SFZOQlh6VklkeDhnY0JseVVVN1NXdFRkUDl0UHhRMGgwdWJreEphM21TNTg2?=
 =?utf-8?B?eHIxbk9jT0NkUkV3NER6Skkvb3hNN0RlSitQRDJqNkJxd2l1a2Q4eWwvcUdp?=
 =?utf-8?B?Vjd0YWcxdG9YcWFjV1Q3TlM0Zk5GclllajRPZDZMOEdMeTZPUE4vN1NsTnRU?=
 =?utf-8?B?U2I0SDZwSVdCcjRVNVhBaW1nc2syWjRsSmZXdDdLOU8rZzZ2Szd4b0lpWGlN?=
 =?utf-8?B?UjJGbGJzemFFVi9mWmM0Si82MmVuNExRb3RPNWNGcGlMN3R0MkZTNGEwemlJ?=
 =?utf-8?Q?rwoesaDOtB99jjo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74ab3a0-ab0b-4065-5c40-08dbb0725d06
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 13:49:03.8396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQAS4BSsx4ynJMoEVYMufbUUvCZrX5pCloaCaizgn8A2zts0+nfePC6ce0oXsgiMX08ADbl97xUN6oKnxCDdhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080128
X-Proofpoint-GUID: z8wjyzV1_Dtk_2HJ4mPFAp8f3xuU_1wr
X-Proofpoint-ORIG-GUID: z8wjyzV1_Dtk_2HJ4mPFAp8f3xuU_1wr
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/09/2023 21:06, Jiri Olsa wrote:
> Currently the multi_kprobe link attach does not check error
> injection list for programs with bpf_override_return helper
> and allows them to attach anywhere. Adding the missing check.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

For the series,

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

...with one small question below...

> ---
>  kernel/trace/bpf_trace.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a7264b2c17ad..c1c1af63ced2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2853,6 +2853,17 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
>  	return arr.mods_cnt;
>  }
>  
> +static int addrs_check_error_injection_list(unsigned long *addrs, u32 cnt)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < cnt; i++) {
> +		if (!within_error_injection_list(addrs[i]))
> +			return -EINVAL;

do we need a check like trace_kprobe_on_func_entry() to verify that
it's a combination of function entry+kprobe override, or is that
handled elsewhere/not needed? perf_event_attach_bpf_prog() does

/*
 * Kprobe override only works if they are on the function entry,
 * and only if they are on the opt-in list.
 */
 	if (prog->kprobe_override &&
 	    (!trace_kprobe_on_func_entry(event->tp_event) ||
 	     !trace_kprobe_error_injectable(event->tp_event)))
 		return -EINVAL;


if this is needed, it might be good to augment the selftest to
cover the case of specifying non-entry+kprobe override. thanks!

Alan


> +	return 0;
> +}
> +
>  int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>  {
>  	struct bpf_kprobe_multi_link *link = NULL;
> @@ -2930,6 +2941,11 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  			goto error;
>  	}
>  
> +	if (prog->kprobe_override && addrs_check_error_injection_list(addrs, cnt)) {
> +		err = -EINVAL;
> +		goto error;
> +	}
> +
>  	link = kzalloc(sizeof(*link), GFP_KERNEL);
>  	if (!link) {
>  		err = -ENOMEM;

