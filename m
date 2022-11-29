Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE31E63C172
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 14:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiK2NwI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 08:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiK2NwG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 08:52:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98082F03B
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 05:52:04 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATAeLhe030884;
        Tue, 29 Nov 2022 13:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tMl99Fn3VXKDosO4xGNDLxVyWt3ziDmxToRKdH2JFnI=;
 b=fPnQtUYW6hqvYXj8AQyhJ612lbGZJsrhzZ7kT3wdIifYx4pyjWM0/z9xdWbonZnpAuYT
 IhL7LTmiEkKSkFrJLfrxR+BM7FHWpGN6r9z46bQFLapRZu327GASPPV1meh0+ImmK6i0
 bnjbPea4vk/qw+m615CexuT8/rFOylhrWnmcIQ5eejX4keZ+AtsizST0FgQPR5Q1Op2Z
 QarNSCic1RkKsn2QdMRDePorws1WSa0K6yZFFLNVLDE8OuD+Q7tuTO8nUe9nOcs61o9M
 nuBpriDA7eEn9Sq2gz4P6mllbxYaxUT3v6vX9gmr5Vj5lLNxzhR8RwyZcGPSzL/yMxKl OQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2pt0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 13:51:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATCb6OA019369;
        Tue, 29 Nov 2022 13:51:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398de41d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 13:51:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fl4IoFgkuqc6vBI3PSa/G2WKGH+G0wUu8YuLGQ0w5QjDV0aWDlafj2IBV0flQHoebb6I+Tf3Jt3Ohb9RU5LE+9cUB3VebbNLiUGkt2izNL0ATLW3sSR7MfHdth/C9cXGmLiz4wBWODkS++NIRppBTcVaZ8MucF/Vfn6Nftpn9id1La1YqahQP79pS9R7e8FAmLTCdDGuujMxYBeRuVaz2F+zSw0yDXg2rIK4vNnPdLzaqiI+7TB9tF3dM+1NmTFSqXQQWQCLdG3ioDpxarpuy1rLwDQO2UKtZUcifS0Y4Mm9eSc4wbWeOukGZhQXLefHTXFScTuSUd16CarpWvCF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMl99Fn3VXKDosO4xGNDLxVyWt3ziDmxToRKdH2JFnI=;
 b=aaC6HFaWlvB2zoNur8kg9H2IBh5rUowGcwLhS3sfIUV1OSvioRHJHSh64XGWfa7A1tZTXcPIra+Szkhp/Y8qnphx+x4sQzHjANOuLMxEnuA9qEQQaoYBVAEwdD7ha4MiP45zRsB1plUH8Hv1oU1VexO1JSjhyhITsU6JvAfBiRjyFvHu14G7CV/3wVBwPJTKWw/D8JzC3K9sNBmtLEREUpJLgsVKpKYE3lh7zlkFeBJsB8P7koS7P+8sTsajgEhBmqrrVBy2lSgpMDio+/SJYHx+2QjAuYWRV+lHVnR+bWbedoa2x/S1hO/ssx1hq4KEDoDuE5fzGjb+S4EPEIQNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMl99Fn3VXKDosO4xGNDLxVyWt3ziDmxToRKdH2JFnI=;
 b=LD5ljRHni66lk/lmeGWnlDZ5Z7J2QIJjUbbgVprjdkL6cnTb1+c/XXpnHccaE5ghlQSw7KLeT8RYWC//sM3udJSYWvuhdqNSRq5lTx5Dch5WQ3xHDhTUfl2+YHK46T2XF7jfFQA3p1ivziz01xhLowPYff5wEdXfyPMjh84bZAg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN4PR10MB5638.namprd10.prod.outlook.com (2603:10b6:806:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 13:51:36 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d44e:a833:13b5:4119]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d44e:a833:13b5:4119%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 13:51:36 +0000
Subject: Re: [RFC bpf-next 2/5] libbpf: provide libbpf API to encode BTF kind
 information
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        haiyue.wang@intel.com, bpf@vger.kernel.org
References: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com>
 <1669225312-28949-3-git-send-email-alan.maguire@oracle.com>
 <CAEf4BzZtOUXxKurpmHzsZ+8FP6aahUNEmcPz=Rr=gkuQPu0yaA@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <658aa4e6-d1ea-c518-0c0d-318811eb48fd@oracle.com>
Date:   Tue, 29 Nov 2022 13:51:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAEf4BzZtOUXxKurpmHzsZ+8FP6aahUNEmcPz=Rr=gkuQPu0yaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SN4PR10MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: b525e920-0ea8-4300-7144-08dad210d4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jCpQznO2g7uT0CMZMFA/pEzJ5bxDu0d1VSaLKtFDptxNd35TIbN7Ye+WHiEe+6WtOA5Bb50ga8nInfIvguyO9p1gzKw8ekwBumbQ7z6fRfKta/mKRAvnkrskQwiGTNRgQfba/RUiEWqG4qcGTLTQZBFJifjhQu4zOPUwtfZTJdr4iCTlNnfqLnwduGsNX2s2ymyKElpWxnpfR5hC5+leQb7qCs9yIokQPsHPA+m+0wlb6Rk7HWLzTQSIDL+J+/mBDDpw3HMTR64xmmyV5VNiNpXHSu620pSCc7vFUr8OptrAWdEQLp6PxGJhjX3LTipVpGmcBv9HmIFCmFlLDYNW/GImfMJ/PKVGd2OkRenoqkS+Zh4Jz+/iG209/tMNdcRubEuQLPHsraaq7NPhw5VZyNc7UjMEX3Ex6N+7YlV88SBkqRNLJ4JvKt7aZ4sCz7cQLGu8AYbiGanWwkl61Ed/Pdcve4v+t6Dge7VIKPQ9TvvqXENwwzeVXdOxqslyXOXfiOwGGYbe428Iqi4Dm7wmi87XHTEZZxn7lcY8jw3k1hdTV576YcIe8wgpg7z8UUYQv4zw+/1DqlygP5uLr0HfcEUe+Yg1qawH+/AzWItRqjU59mfii0swkp0SJj87VQbfk9pl/nLOdsApmQttARmmJ6NZbALkcbOSVcEXzq1W/p4VT997qUbrAkfVgY1ILdEkjy52pZzswRTN9VTRUcwRKgwZVMm248KbfKPs3xApYng6HgWthX57MH7PeUs5RKd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(36756003)(31686004)(41300700001)(7416002)(5660300002)(30864003)(2906002)(8936002)(44832011)(31696002)(66556008)(38100700002)(66476007)(86362001)(8676002)(4326008)(6916009)(316002)(66946007)(83380400001)(478600001)(186003)(2616005)(966005)(6486002)(53546011)(6666004)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1loR0g4N00vTC9zS09rMW9sYkxQV0xrMXFiWmhFVjViMkFMVm5zSU41cnZH?=
 =?utf-8?B?R29nYmw2NTJpeGFHa3VvaVRGdVVHNjlxRFY3QVFvYnowck1meGNFTlZjUVVy?=
 =?utf-8?B?aXhlVW9XYXo5NnZCWkc4NUF4b3c3K1Y4Y2RDbEIxWW1VQkFReWdRWlU1WGlI?=
 =?utf-8?B?czdoTHBWUUJRWUJUb3VXN3ZKS0JqU0ptL3ZZdzVoWjc1TFJDaDBVVzNObUFS?=
 =?utf-8?B?RTBpRUpCMWQzcUtUa2RZampBY28yUzN3MUNIbWpxZHZzdURKVzMxSEgwWjZL?=
 =?utf-8?B?MDM1ajlrcExrTTMrVWJPTUJLTFFJVlo3L3V5S0lDSWJ1KzliSm14MXBuOUlN?=
 =?utf-8?B?bG1YS1ZYZ0Y1eUdiUUhzZ0ZxcTc4R3ludFE1bFZXR2N0VXNsOUI3dmptSUhQ?=
 =?utf-8?B?NUNrN2xndGtIWmcvYnRxQWFZcTg4T2wvMSt6bVRVSmRNSW1iRUdISUowekJa?=
 =?utf-8?B?S011Sjd5NXM4c0RXeEtlUUcwQ25JZUpDZkJPT3liYnE5Q1RYU3BuaU5KaW5U?=
 =?utf-8?B?VHFEVFdFM0RnOGlUOStoOHNsQlFFVGtKZFB6QjFFcUViT3oyUnBDRERTUzhQ?=
 =?utf-8?B?a29zQ2xxdFVQTFdQUDlWeGJZeGYwelN4NlE2dE1nZjVHbE81MHZrZENIQzNk?=
 =?utf-8?B?MFNyK1pCQWhDN0UvWWwxWWhlcGJMdmtiTm1xcE1IQVMraE9seEsrWlFJY01N?=
 =?utf-8?B?N2tmZHJNRzY1eWo2SzltbUs4bG5peWN0ZHZJc0ZINTUwK2JTd1pFMndWeUk4?=
 =?utf-8?B?anJ5ZlRRcS9tZnArcU9PVVloNWZUWlRBZ2FocVBmNWEyZk5ialJNZFEreVVO?=
 =?utf-8?B?OUlROGZUdlA4L0hreThxUTBtYmxLOVpTcEhEazZNMkRaMXhQRTQydlhrdmtD?=
 =?utf-8?B?N1V0Z3JOYWZpRXVlOXErUUxYOHJHeWFZeUUxRVhYQXB3SGRhMU8vYW1FcTRB?=
 =?utf-8?B?Y2dWRmVTVGtkeEwvcnlYTlVHRExUelNCN0RTTUZNb3ZJU3NyVThGc0xWQUd6?=
 =?utf-8?B?SzllNi9qd0lBS2FNcXJiRGhteHY1YjJqcFluOUI1MFJDK1ZTdXlKQ0Y4dElk?=
 =?utf-8?B?QjFCcW03blRETnlVc3VYanNzN3lFa2ROdldTeEZsbC9aYVR6S2U4WXZUelMz?=
 =?utf-8?B?NitSa0RTRUpMTU4vOEZaQVI3Ym9scFZnZkh1TTBkNjRoWFdlTUpyZVZ0WVJ4?=
 =?utf-8?B?QXFPanZGeW14NDdCbnh2akdQSE0yTzNhTElaVTkwNWdHWXBHOTVPS0kvNDVj?=
 =?utf-8?B?RHg3ano5RTJCUEFmeFJTMDM0UU45S1Y5Mmh6UXoxVzd1eUhuVW5nRXJXSkV0?=
 =?utf-8?B?L1NOUnYwRGVZNTVqdnBGMzZlNWhoUzBqUDVXYjBpLzlONHFWSmhnMHFDVitB?=
 =?utf-8?B?OW5YT3ZjSklQbzVCdjdoNHk4d3dVSTVibVVvYXpMOVB0azRkRFN5dmo3dUpG?=
 =?utf-8?B?RjdHc25jd2gxYUR0eklHQVBkUHZoWFFRZitYRHJ0T29RcDlZb0xJNkdnNXhu?=
 =?utf-8?B?dW11dzZsU29jTmRQTTY3alhGRWo3U1ZzT0IwQkxHdDdmSS82Z1JzZ1IxRkcy?=
 =?utf-8?B?UGI1bkY2T1h6SXBvSXBZckNtcE9GWWtBbWRBWm9BblROUG41TFhZUDFxUEVH?=
 =?utf-8?B?ZzlwTEdtUjJvM1FJR2FKazhYYjdjN01TK3IzWmd4SUxwZFV2Y2t5azA1Nm5H?=
 =?utf-8?B?eVBMUkFIQWlOanJ6UWQ2OWpKYUh3K2c5M3gwb3RRbTFBaHdNQ3UyU1ZRMThz?=
 =?utf-8?B?NCtBWU50SGk5NVpPWHRsNHp3clNNTzRNcmFXV1gvallWYmFjNzl4NVJqY1FJ?=
 =?utf-8?B?S0ZNc2hrNmNxVCtQNTVsejljV25aSm5CTUlRbUVjc2pSZHpob2ZybEVoRmRQ?=
 =?utf-8?B?bTRrYktBMngxNHhZYlJIRFNhZ0FJcnRaZHpIcWI0K0FMMzhiN0tZQzR3VDZM?=
 =?utf-8?B?ZWNCSTdFRnRScTJrOWxBVmxLVkVDcnBMb2o2b2w2NVQ4MkJTTGxzUXBHNU1U?=
 =?utf-8?B?cTM4S2cwNmpIT3ZNS3VTL2pscElQaU1UUEgyU0tUZmZ0YWM3TkV6QllodHBv?=
 =?utf-8?B?MG4yVlhwWlNvRURwdVBaT010L0Y3aG1GSnVFek5RRXpZaGQ2YUJZZ2JkM1E0?=
 =?utf-8?B?RG9iVVc4QnZmWWNaSHIva0tWaCtNdHQzZnBNUGZKMy9UVkErT0FPRy9IRHJJ?=
 =?utf-8?Q?jtEPKfQAY5zAut3Z3OClDGw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZitsK2FtN1YySE14VGlma014N2xGNmNpNUdYK01Jc09VS0xJWThReWhQNG9p?=
 =?utf-8?B?aFowejF5Q0pUZWtlYUZRd2UrcGRsaS82ZlJTUHVJa21VUUhUYWJrZFdQOXlV?=
 =?utf-8?B?VElDeTM4Mk9ZUmtyRC9hM3dSZkMvOU0yTFMzeDR0c0tCWmhiL1pIdWp2U0ly?=
 =?utf-8?B?Vk9LRTRidlR2SnJ3cFBGcDFWeXd4aHlEaU8wWEZZZlYrVWJqTXV6dU5lMk4z?=
 =?utf-8?B?RytuMVBRbElEaERHamYzek40V1VtU3kycDJEK0ZzQWpyLzFYUmpOZzg0VSsv?=
 =?utf-8?B?N0g0SUpzYVlPL0dKQ21iYnUxUDNDNTBUWjZDWnZTbSszTkFVZ1daVGJXRjIx?=
 =?utf-8?B?MlBwUXpPczQ1RVdEdTdlZGViWG1WUDIzZTJLNjUxL1JxU3JaKzdTc1NXTUFU?=
 =?utf-8?B?NTZQK2Y4bEI1U1UrR09xbHM4RUFoeGtaT0lyMjFYNmpjanNndVJwNFRFemdn?=
 =?utf-8?B?ODErQ1BFaUh2NnlMMC95UXduNUxSVlh3YVBZU0t2TFU3UGFobEhGYUNjanlz?=
 =?utf-8?B?QStUdnU0aXZVOGRTLzZTQUR2bWRNdGw3dEVoYUtNNk5DUWEvd2JvMVdWTU52?=
 =?utf-8?B?VldQV1NNUVcrbnNYaisyVng3alBOMUtXQkx0V0FPVFZaeXRqS1VEbFVuZ05Y?=
 =?utf-8?B?SXpyMHBVbTNVRXRSMC8xaFJYeUlvalRRZGhmTGY5dlpmYTlVTmUrQXN3ODE0?=
 =?utf-8?B?RUVXVHE1TG1zVC90d3o5Z1VnWG56Z29nZGs3SVJvVkNIa29Hdkl3VFBEcGw0?=
 =?utf-8?B?cmMrdlF2bGZoRUR2Q1VvVUkvNDc0VnVMdzdnbzRRbGN4UlNodUlUZzk1eUgx?=
 =?utf-8?B?YlQ0K0ZCOVpIcmtBaEVlanN3QVRBWTVPN3dabFZnUTVHS0VDdDZldlNsVFhK?=
 =?utf-8?B?NjlKaVUwcUpQaVg5ZlB0U2Y5VkRqRzBmSlpOOHlFNFRsU2lEZWFOWk9GOFBl?=
 =?utf-8?B?YWxkWDZwUVE3L1AxSXliQkV5dDd6TThPVWxIak9iU2ZZL0VXUDU3TE40MlA3?=
 =?utf-8?B?bVZ1Y25VQ1hGRjR6M3JabjdTRG0wdjlGY0M5dFpSWFZ5b3RMbU5MWUxlUUFu?=
 =?utf-8?B?M0FyaFdSb3poMC9zMmFLM3RmQVBHN2U5dld2cnFkcHNmeGlTWStHdXNpOSts?=
 =?utf-8?B?aHZiMnV2RThsbUhGZk4zU1hORmY5MzRYSENCSjlaRVJnRy9TNXlHSmRweVFI?=
 =?utf-8?B?YmhSRzdXQVlGSDN2UVJHT1IyV003MTBXNTN3eENkaEVkM0c2SG45dUxyYXhz?=
 =?utf-8?B?djF4b1AwUTJ4Vk55WWJ1NjRyWk9TcWMvZlVRakE0QWJLWFpVRHhOenZQL1di?=
 =?utf-8?B?cHRBdm5ZRlFMVUR6Z0ZLc3dpQm5od01qQlhuci9NRk9aYVFTM1c0VFUraHFW?=
 =?utf-8?B?LzNJd2U4eTJkUm1Oa2J2WUk3bVFoTTVPeTJLb0NRakhBL2pzenczMjFVbTdG?=
 =?utf-8?B?bjQ3OXhITmZ5bW9JZVM5WmNNUVFnbStLOHpJaG4veFhKNlA0M0NiQ0pEOW5w?=
 =?utf-8?B?Q1ViemFuU2JramFsK0xROHhaZmZnNGY0L3ptYVVkZVhCM09ydXVLUGllZFNz?=
 =?utf-8?B?aXRidz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b525e920-0ea8-4300-7144-08dad210d4b9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 13:51:36.0328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIXRKBpd6dSnOll4C1Cdd3AfLWQrtkt+9lRww1GPfLvveEUaHXjJmee1tD0YFkh1iejXbq1knCN6A03ifUI5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_08,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290080
X-Proofpoint-GUID: qz5ir63IHtspTtvnr1G1sip1EuxGBICv
X-Proofpoint-ORIG-GUID: qz5ir63IHtspTtvnr1G1sip1EuxGBICv
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 29/11/2022 05:35, Andrii Nakryiko wrote:
> On Wed, Nov 23, 2022 at 9:42 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> This can be used by BTF parsers to handle kinds they do not know about;
>> this is useful when the encoding libbpf is more recent than the parsing
>> BTF; the parser can then skip over the encoded types it does not know
>> about.
>>
>> We use BTF to encode the BTF kinds that are known at the time of
>> BTF encoding; the use of basic BTF kinds (structs, arrays, base types)
>> to describe each kind and any associated metadata allows BTF parsing
>> to handle new kinds that the parser (in libbpf or the kernel) does
>> not know about.  These kinds will not be used, but since we know
>> their format they can be skipped over and the rest of the BTF can
>> be parsed.  This means we can encode BTF without worrying about the
>> kinds a BTF parser knows about, and means we can avoid using
>> --skip_new_kind solutions.  This is valuable, as if kernel BTF encodes
>> everything it can, something as simple as a libbpf package update
>> then unlocks that encoded information, whereas if we encode
>> pessimistically and drop representations of new kinds, this is not
>> possible.
>>
>> So, in short, by carrying a representation of all the kinds encoded,
>> parsers can parse all of the encoded kinds, even if they cannot use
>> them all.
>>
>> We use BTF itself to carry this representation because this approach
>> does not require BTF parsing to understand a new BTF header format;
>> BTF parsing simply sees some additional types it does not do anything
>> with.  However, a BTF parser that knows about the encoding of kind
>> information can use this information to guide parsing.
>>
>> The process works by explicitly adding btf structs for each kind.
>> Each struct consists of a "struct __btf_type" followed by an array of
>> metadata structs representing the following metadata (for those kinds
>> that have it).  For kinds where a single metadata structure is used,
>> the metadata array has one element.  For kinds where the number
>> of metadata elements varies as per the info.vlen field, a zero-element
>> array is encoded.
>>
>> For a given kind, we add a struct __BTF_KIND_<kind>.  For example,
>>
>> struct __BTF_KIND_INT {
>>         struct __btf_type type;
>> };
>>
>> For a type with one metadata element, the representation looks like
>> this:
>>
>> struct __BTF_KIND_META_ARRAY {
>>         __u32 type;
>>         __u32 index_type;
>>         __u32 nelems;
>> };
>>
>> struct __BTF_KIND_ARRAY {
>>         struct __btf_type type;
>>         struct __BTF_KIND_META_ARRAY meta[1];
>> };
>>
>> For a type with an info.vlen-determined number of following metadata
>> objects, a zero-length array is used:
>>
>> struct __BTF_KIND_STRUCT {
>>         struct __btf_type type;
>>         struct __BTF_KIND_META_STRUCT meta[0];
>> };
>>
>> In order to link kind numeric kind values to the appropriate struct,
>> a typedef is added; for example:
>>
>> typedef struct __BTF_KIND_INT __BTF_KIND_1;
>>
>> When BTF parsing encounters a kind that is not known, the
>> typedef __BTF_KIND_<kind number> is looked up, and we find which
>> struct type id it points to.  So
>>
>>         1 -> typedef __BTF_KIND_1 -> struct __BTF_KIND_INT
>>
>> This approach is preferred, since it ensures the structs representing
>> BTF kinds have names which match their associated kind rather than
>> an opaque number.
>>
>> From there, BTF parsing can look up that struct and determine
>>         - its basic size;
>>         - if it has metadata; and if so
>>         - how many array instances are present;
>>                 - if 0, we know it is a vlen-determined number;
>>                   i.e. vlen * meta_size
>>                 - if > 0, simply use the overall struct size;
>>
>> Based upon that information, BTF parsing can proceed for such
>> unknown kinds, since sufficient information was provided
>> at encoding time to skip over them.
>>
>> Note that this assumes that the above kind-related data
>> structures are represented in BTF _prior_ to any kinds that
>> are new to the parser.  It also assumes the basic kinds
>> required to represent kinds + metadata; base types, structs,
>> arrays, etc.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c      | 281 +++++++++++++++++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/btf.h      |  10 ++
>>  tools/lib/bpf/libbpf.map |   1 +
>>  3 files changed, 292 insertions(+)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 71e165b..e3cea44 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -28,6 +28,16 @@
>>
>>  static struct btf_type btf_void;
>>
>> +/* info used to encode/decode an unrecognized kind */
>> +struct btf_kind_desc {
>> +       int kind;
>> +       const char *struct_name;        /* __BTF_KIND_ARRAY */
>> +       const char *typedef_name;       /* __BTF_KIND_2 */
>> +       const char *meta_name;          /* __BTF_KIND_META_ARRAY */
>> +       int nr_meta;
>> +       int meta_size;
>> +};
>> +
>>  struct btf {
>>         /* raw BTF data in native endianness */
>>         void *raw_data;
>> @@ -5011,3 +5021,274 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
>>
>>         return 0;
>>  }
>> +
>> +/* Here we use BTF to encode the BTF kinds that are known at the time of
>> + * BTF encoding; the use of basic BTF kinds (structs, arrays, base types)
>> + * to describe each kind and any associated metadata allows BTF parsing
>> + * to handle new kinds that the parser (in libbpf or the kernel) does
>> + * not know about.  These kinds will not be used, but since we know
>> + * their format they can be skipped over and the rest of the BTF can
>> + * be parsed.  This means we can encode BTF without worrying about the
>> + * kinds a BTF parser knows about, and means we can avoid using
>> + * --skip_new_kind solutions.  This is valuable, as if kernel BTF encodes
>> + * everything it can, something as simple as a libbpf package update
>> + * then unlocks that encodeded information, whereas if we encode
>> + * pessimistically and drop representations of new kinds, this is not
>> + * possible.
>> + *
>> + * So, in short, by carrying a representation of all the kinds encoded,
>> + * parsers can parse all of the encoded kinds, even if they cannot use
>> + * them all.
>> + *
>> + * We use BTF itself to carry this representation because this approach
>> + * does not require BTF parsing to understand a new BTF header format;
>> + * BTF parsing simply sees some additional types it does not do anything
>> + * with.  A BTF parser that knows about the encoding of kind information
>> + * however can use this information in parsing.
>> + *
>> + * The process works by explicitly adding btf structs for each kind.
>> + * Each struct consists of a struct __btf_type followed by an array of
>> + * metadata structs representing the following metadata (for those kinds
>> + * that have it).  For kinds where a single metadata structure is used,
>> + * the metadata array has one element.  For kinds where the number
>> + * of metadata elements varies as per the info.vlen field, a zero-element
>> + * array is encoded.
>> + *
>> + * For a given kind, we add a struct __BTF_KIND_<kind>.  For example,
>> + *
>> + * struct __BTF_KIND_INT {
>> + *     struct __btf_type type;
>> + * };
>> + *
>> + * For a type with one metadata element, the representation looks like
>> + * this:
>> + *
>> + * struct __BTF_KIND_META_ARRAY {
>> + *     __u32 type;
>> + *     __u32 index_type;
>> + *     __u32  nelems;
>> + * };
>> + *
>> + * struct __BTF_KIND_ARRAY {
>> + *     struct __btf_type type;
>> + *     struct __BTF_KIND_META_ARRAY meta[1];
>> + * };
>> + *
>> + *
>> + * For a type with an info.vlen-determined number of following metadata
>> + * objects, a zero-length array is used:
>> + *
>> + * struct __BTF_KIND_STRUCT {
>> + *     struct __btf_type type;
>> + *     struct __BTF_KIND_META_STRUCT meta[0];
>> + * };
>> + *
>> + * In order to link kind numeric kind values to the appropriate struct,
>> + * a typedef is added; for example:
>> + *
>> + * typedef struct __BTF_KIND_INT __BTF_KIND_1;
>> + *
>> + * When BTF parsing encounters a kind that is not known, the
>> + * typedef __BTF_KIND_<kind number> is looked up, and we find which
>> + * struct type id it points to.  So
>> + *
>> + *     1 -> typedef __BTF_KIND_1 -> struct __BTF_KIND_INT
>> + *
>> + * This approach is preferred, since it ensures the structs representing
>> + * BTF kinds have names which match their associated kind rather than
>> + * an opaque number.
>> + *
>> + * From there, BTF parsing can look up that struct and determine
>> + *     - its basic size;
>> + *     - if it has metadata; and if so
>> + *     - how many array instances are present;
>> + *             - if 0, we know it is a vlen-determined number;
>> + *             - if > 0, simply use the overall struct size;
>> + *
>> + * Based upon that information, BTF parsing can proceed for such
>> + * unknown kinds, since sufficient information was provided
>> + * at encoding time.
>> + *
>> + * Note that this assumes that the above kind-related data
>> + * structures are represented in BTF _prior_ to any kinds that
>> + * are new to the parser.  It also assumes the basic kinds
>> + * required to represent kinds + metadata; base types, structs,
>> + * arrays, etc.
>> + */
> 
> Goodness gracious! :)
> 
> Aesthetics of all this aside (which hurts me deeply, but let's ignore
> that for a moment), this whole requirement that these
> self-describing-but-also-convention-driven types which are supposed to
> help with parsing types information are themselves in types
> information is quite unusual. Yes, by saying "we assume they come
> before a first type with unknown kind" we kind of work around this,
> but even the fact that you can use btf__type_by_id() and
> btf__find_by_name_kind() before BTF is fully parsed is kind of by
> accident. All-in-all this screams "a kludge" at me, sorry.
> 
> I really don't like this approach, even if *technically* it would
> work. But even if so, it would add quite a bunch of size to BTF just
> to self-describe it.
> 
> Let's go again (and in more detail) over my alternative proposal I
> briefly described in another email thread.
> 
> So, what I'm proposing is similar in spirit and solves all the same
> goals you have (and actually some more, I'll point this out below).
> The only downside is that we'll need to, again, teach kernel to
> understand this BTF format extension to allow kernel to use it (so we
> still will need an opt-in flag for pahole, unfortunately, but
> hopefully just this one time). That's pretty much the only downside.
> But it's more compact, simpler and more straightforward, more elegant
> (IMO), and it is easy for libbpf to sanitize it for old kernels.
> 
> Ok, so it's pretty much completely described by these changes:
> 
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -8,6 +8,21 @@
>  #define BTF_MAGIC      0xeB9F
>  #define BTF_VERSION    1
> 
> +struct btf_kind_meta {
> +       /* extra flags, initially define just one:
> +        * 0x01 - required or optional (is it safe to skip if unknown)
> +        */
> +       __u16 flags;
> +       __u8 info_sz;
> +       __u8 elem_sz;
> +};
> +
> +struct btf_metadata {
> +       __u8 kind_meta_cnt;
> +       __u32 :0;
> +       struct btf_kind_meta[];
> +};
> +
>  struct btf_header {
>         __u16   magic;
>         __u8    version;
> @@ -19,6 +34,8 @@ struct btf_header {
>         __u32   type_len;       /* length of type section       */
>         __u32   str_off;        /* offset of string section     */
>         __u32   str_len;        /* length of string section     */
> +       __u32   meta_off;
> +       __u32   meta_len;
>  };
>

Ok, if we're going this route though, let's try to think through any 
other info we need to add so the format changes are a one-time thing.
We should add flags too. One current use-case would be the 
"is this BTF standalone, or does it require base BTF?" [1]. Either using
an existing value in the header flags field, or using the space for a flags 
field in  struct btf_metadata would probably make sense.

Do we have any other outstanding issues with BTF that would be eased
by some sort of up-front declaration? If we can at least tackle those
things at once, the pain will be somewhat less when updating the toolchain.

> 
> So, we add meta_off/meta_len fields to btf_header, which, if non-zero,
> will point to a piece of metadata (4-byte aligned) that's described by
> struct btf_metadata.
> 
> In btf_metadata, the first byte records the number of known BTF kinds,
> we have three more bytes for extra flags or counters for
> extensibility, they should be zeroed out right now.
> 

Right; see above for one flags use-case.

> After these 4 bytes we have kind_meta_cnt struct btf_kind_meta
> entries, each 4-byte long. It's a 1-indexed array, where each entry
> corresponds to sequentially numbered BTF kinds. First two bytes are
> reserved for flags and stuff like that. Among those, I think the most
> useful right now would be the "optional flag". If set, it would mean
> that generally speaking it's safe to skip types of that kind without
> losing integrity of the data. So e.g., we could have used that for
> DECL_TAGS, or perhaps even for FUNCs, if we had this metadata back
> then, as these kinds are, generally speaking, not referenced from
> other types (not 100% for FUNCs, as we can have FUNC externs, but
> those came later). Anyways, for kernel needs we can say that optional
> kinds don't cause failure to validate BTF.
> 

This would definitely be useful; but are you saying here that
a struct with a reference to an unknown kind should fail BTF
validation (something like a struct with an enum64 member parsed by a
libbpf prior to enum64 support)? Not sure there's any alternative
for a case like that...

> *But for security reasons we should make the kernel zero-out
> corresponding parts of type information, just to prevent injection of
> well-known data by malicious user*.
> 
> Next, to the meat of the proposal. info_sz is size in bytes of an
> additional singular information (e.g., btf_array for ARRAY kind,
> 4-byte info for INT kind, etc) that goes after common 12-byte struct
> btf_type. It can be zero, of course. elem_sz is a size in bytes of
> each nested element (field info for STRUCT, arg info for FUNC_ARG,
> etc). Number of elements is defined by btf_vlen(t), which works for
> any kind, regardless if it's known or not. If elem_sz is zero, KIND
> can't have nested elements (and thus if vlen is non-zero, that's a
> corruption).
> 
> That's it. We don't allow mixing differently-sized nested elements
> within a single kind, but we don't have that today and we don't have
> any meaningful ways to express this. And I don't think we'd want to do
> this anyways (there are way to work around that if absolutely
> necessary, as well).
> 
> From libbpf's point of view, this metadata section is easy to
> sanitize, as kernel allows btf_headers of bigger size than is known to
> it, provided they are zeroed out. So libbpf will just zero out
> meta_off/meta_len fields, and contents of the metadata section.
> 
> As for the size, it adds just 8 + 4 + 19 * 4 = 88 bytes to the overall
> BTF size. It's nothing. I didn't count the total size for your
> approach, but at the very least it would be 19 * 2 * sizeof(struct
> btf_type) (=12) = 456, but that's super conservative.
> 
> Note also that each btf_type can always have a name (described by
> btf_type->name_off), so generic BTF tools can easily output what is
> the name of the skipped entity, regardless of its actual kind. Tools
> can also point out how many nested elements it is supposed to have.
> Both are quite nice features, IMO.
> 
> Anyways, that's what I had in mind. I think we should bite a bullet
> and do it, so that future extensions can make use of this
> self-describing metadata.
> 
> Thoughts?
>

It'll work, a few specific questions we should probably resolve up front:

- We can deduce the presence of the metadata info from the header length, so we
  don't need a BTF version bump, right?

- from the encoding perspective, you mentioned having metadata opt-in;
  so I presume we'd have a btf__add_metadata() API (it is zero by default so
  accepted by the kernel I think) if --encode_metadata is set? Perhaps eventually
  we could move to opt-out.

- there are some cases where what is valid has evolved over time. For example,
  kind flags have appeared for some kinds; should we have a flag for "supports kind
  flag"? (set for struct/union/enum/fwd/eum64)?

I can probably respin what I have, unless you want to take it on?

[1] https://lore.kernel.org/bpf/CAEf4BzYXRT9pFmC1RqnNBmvQWGQkd0zs9rbH9z9Ug8FWOArb_Q@mail.gmail.com/
 
> 
>> +
>> +/* info used to encode a kind metadata field */
>> +struct btf_meta_field {
>> +       const char *type;
>> +       const char *name;
>> +       int size;
>> +       int type_id;
>> +};
>> +
>> +#define BTF_MAX_META_FIELDS             10
>> +
>> +#define BTF_META_FIELD(__type, __name)                                 \
>> +       { .type = #__type, .name = #__name, .size = sizeof(__type) }
>> +
>> +#define BTF_KIND_STR(__kind)   #__kind
>> +
>> +struct btf_kind_encoding {
>> +       struct btf_kind_desc kind;
>> +       struct btf_meta_field meta[BTF_MAX_META_FIELDS];
>> +};
>> +
>> +#define BTF_KIND(__name, __nr_meta, __meta_size, ...)                  \
>> +       { .kind = {                                                     \
>> +         .kind = BTF_KIND_##__name,                                    \
>> +         .struct_name = BTF_KIND_PFX#__name,                           \
>> +         .meta_name = BTF_KIND_META_PFX #__name,                       \
>> +         .nr_meta = __nr_meta,                                         \
>> +         .meta_size = __meta_size,                                     \
>> +       }, .meta = { __VA_ARGS__ } }
>> +
>> +struct btf_kind_encoding kinds[] = {
>> +       BTF_KIND(UNKN,          0,      0),
>> +
>> +       BTF_KIND(INT,           0,      0),
>> +
>> +       BTF_KIND(PTR,           0,      0),
>> +
>> +       BTF_KIND(ARRAY,         1,      sizeof(struct btf_array),
>> +                                       BTF_META_FIELD(__u32, type),
>> +                                       BTF_META_FIELD(__u32, index_type),
>> +                                       BTF_META_FIELD(__u32, nelems)),
>> +
>> +       BTF_KIND(STRUCT,        0,      sizeof(struct btf_member),
>> +                                       BTF_META_FIELD(__u32, name_off),
>> +                                       BTF_META_FIELD(__u32, type),
>> +                                       BTF_META_FIELD(__u32, offset)),
>> +
>> +       BTF_KIND(UNION,         0,      sizeof(struct btf_member),
>> +                                       BTF_META_FIELD(__u32, name_off),
>> +                                       BTF_META_FIELD(__u32, type),
>> +                                       BTF_META_FIELD(__u32, offset)),
>> +
>> +       BTF_KIND(ENUM,          0,      sizeof(struct btf_enum),
>> +                                       BTF_META_FIELD(__u32, name_off),
>> +                                       BTF_META_FIELD(__s32, val)),
>> +
>> +       BTF_KIND(FWD,           0,      0),
>> +
>> +       BTF_KIND(TYPEDEF,       0,      0),
>> +
>> +       BTF_KIND(VOLATILE,      0,      0),
>> +
>> +       BTF_KIND(CONST,         0,      0),
>> +
>> +       BTF_KIND(RESTRICT,      0,      0),
>> +
>> +       BTF_KIND(FUNC,          0,      0),
>> +
>> +       BTF_KIND(FUNC_PROTO,    0,      sizeof(struct btf_param),
>> +                                       BTF_META_FIELD(__u32, name_off),
>> +                                       BTF_META_FIELD(__u32, type)),
>> +
>> +       BTF_KIND(VAR,           1,      sizeof(struct btf_var),
>> +                                       BTF_META_FIELD(__u32, linkage)),
>> +
>> +       BTF_KIND(DATASEC,       0,      sizeof(struct btf_var_secinfo),
>> +                                       BTF_META_FIELD(__u32, type),
>> +                                       BTF_META_FIELD(__u32, offset),
>> +                                       BTF_META_FIELD(__u32, size)),
>> +
>> +
>> +       BTF_KIND(FLOAT,         0,      0),
>> +
>> +       BTF_KIND(DECL_TAG,      1,      sizeof(struct btf_decl_tag),
>> +                                       BTF_META_FIELD(__s32, component_idx)),
>> +
>> +       BTF_KIND(TYPE_TAG,      0,      0),
>> +
>> +       BTF_KIND(ENUM64,        0,      sizeof(struct btf_enum64),
>> +                                       BTF_META_FIELD(__u32, name_off),
>> +                                       BTF_META_FIELD(__u32, val_lo32),
>> +                                       BTF_META_FIELD(__u32, val_hi32)),
>> +};
>> +
>> +/* Try to add representations of the kinds supported to BTF provided.  This will allow parsers
>> + * to decode kinds they do not support and skip over them.
>> + */
>> +int btf__add_kinds(struct btf *btf)
>> +{
>> +       int btf_type_id, __u32_id, __s32_id, struct_type_id;
>> +       char name[64];
>> +       int i;
>> +
>> +       /* should have base types; if not bootstrap them. */
>> +       __u32_id = btf__find_by_name(btf, "__u32");
>> +       if (__u32_id < 0) {
>> +               __s32 unsigned_int_id = btf__find_by_name(btf, "unsigned int");
>> +
>> +               if (unsigned_int_id < 0)
>> +                       unsigned_int_id = btf__add_int(btf, "unsigned int", 4, 0);
>> +               __u32_id = btf__add_typedef(btf, "__u32", unsigned_int_id);
>> +       }
>> +       __s32_id = btf__find_by_name(btf, "__s32");
>> +       if (__s32_id < 0) {
>> +               __s32 int_id = btf__find_by_name_kind(btf, "int", BTF_KIND_INT);
>> +
>> +               if (int_id < 0)
>> +                       int_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
>> +               __s32_id = btf__add_typedef(btf, "__s32", int_id);
>> +       }
>> +
>> +       /* add "struct __btf_type" if not already present. */
>> +       btf_type_id = btf__find_by_name(btf, "__btf_type");
>> +       if (btf_type_id < 0) {
>> +               __s32 union_id = btf__add_union(btf, NULL, sizeof(__u32));
>> +
>> +               btf__add_field(btf, "size", __u32_id, 0, 0);
>> +               btf__add_field(btf, "type", __u32_id, 0, 0);
>> +
>> +               btf_type_id = btf__add_struct(btf, "__btf_type", sizeof(struct btf_type));
>> +               btf__add_field(btf, "name_off", __u32_id, 0, 0);
>> +               btf__add_field(btf, "info", __u32_id, sizeof(__u32) * 8, 0);
>> +               btf__add_field(btf, NULL, union_id, sizeof(__u32) * 16, 0);
>> +       }
>> +
>> +       for (i = 0; i < ARRAY_SIZE(kinds); i++) {
>> +               struct btf_kind_encoding *kind = &kinds[i];
>> +               int meta_id, array_id = 0;
>> +
>> +               if (btf__find_by_name(btf, kind->kind.struct_name) > 0)
>> +                       continue;
>> +
>> +               if (kind->kind.meta_size != 0) {
>> +                       struct btf_meta_field *field;
>> +                       __u32 bit_offset = 0;
>> +                       int j;
>> +
>> +                       meta_id = btf__add_struct(btf, kind->kind.meta_name, kind->kind.meta_size);
>> +
>> +                       for (j = 0; bit_offset < kind->kind.meta_size * 8; j++) {
>> +                               field = &kind->meta[j];
>> +
>> +                               field->type_id = btf__find_by_name(btf, field->type);
>> +                               if (field->type_id < 0) {
>> +                                       pr_debug("cannot find type '%s' for kind '%s' field '%s'\n",
>> +                                                kind->meta[j].type, kind->kind.struct_name,
>> +                                                kind->meta[j].name);
>> +                               } else {
>> +                                       btf__add_field(btf, field->name, field->type_id, bit_offset, 0);
>> +                               }
>> +                               bit_offset += field->size * 8;
>> +                       }
>> +                       array_id = btf__add_array(btf, __u32_id, meta_id,
>> +                                                 kind->kind.nr_meta);
>> +
>> +               }
>> +               struct_type_id = btf__add_struct(btf, kind->kind.struct_name,
>> +                                                sizeof(struct btf_type) +
>> +                                                (kind->kind.nr_meta * kind->kind.meta_size));
>> +               btf__add_field(btf, "type", btf_type_id, 0, 0);
>> +               if (kind->kind.meta_size != 0)
>> +                       btf__add_field(btf, "meta", array_id, sizeof(struct btf_type) * 8, 0);
>> +               snprintf(name, sizeof(name), BTF_KIND_PFX "%u", i);
>> +               btf__add_typedef(btf, name, struct_type_id);
>> +       }
>> +       return 0;
>> +}
>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>> index 8e6880d..a054082 100644
>> --- a/tools/lib/bpf/btf.h
>> +++ b/tools/lib/bpf/btf.h
>> @@ -219,6 +219,16 @@ LIBBPF_API int btf__add_datasec_var_info(struct btf *btf, int var_type_id,
>>  LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
>>                             int component_idx);
>>
>> +/**
>> + * @brief **btf__add_kinds()** adds BTF representations of the kind encoding for
>> + * all of the kinds known to libbpf.  This ensures that when BTF is encoded, it
>> + * will include enough information for parsers to decode (and skip over) kinds
>> + * that the parser does not know about yet.  This ensures that an older BTF
>> + * parser can read newer BTF, and avoids the need for the BTF encoder to limit
>> + * which kinds it emits to make decoding easier.
>> + */
>> +LIBBPF_API int btf__add_kinds(struct btf *btf);
>> +
>>  struct btf_dedup_opts {
>>         size_t sz;
>>         /* optional .BTF.ext info to dedup along the main BTF info */
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 71bf569..6121ff1 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -375,6 +375,7 @@ LIBBPF_1.1.0 {
>>                 bpf_link_get_fd_by_id_opts;
>>                 bpf_map_get_fd_by_id_opts;
>>                 bpf_prog_get_fd_by_id_opts;
>> +               btf__add_kinds;
>>                 user_ring_buffer__discard;
>>                 user_ring_buffer__free;
>>                 user_ring_buffer__new;
>> --
>> 1.8.3.1
>>
