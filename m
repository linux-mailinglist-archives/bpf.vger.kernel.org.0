Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B143068EE40
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 12:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBHLuj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 06:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHLui (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 06:50:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF346725;
        Wed,  8 Feb 2023 03:50:36 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3189Z5sN005255;
        Wed, 8 Feb 2023 11:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=35CkJnXJUwgQ5kg9tw1KXqQ4yfFedf3spxbaiQ0jPbs=;
 b=DcCKil7s3vNyuYm1iD7FKmCg+xpVtahgNEDk9xYDH7gRV6daFf1zUt/Zo/dGPgAbg6C+
 +xr1nDS8r59b8OeM4mI1akhqK1QrvwqBA1qL89dy4GPlqt7S3VC6FMjIpJo1AT6gckat
 AMMr0je11dicUhhqv73tWWr+1eLW7yPkez2RZaHK0MfSP98XPccz20gXxH9SRbHyy21V
 kST/M8Wzb4JAQUNqjeaM6WCFW+ou6WXx6MfslDeCfxSOXeCb2IRLAUT4PwRZp5NPeJHt
 P/+yj04PS4i24ewdLHGT8Ziwt6HX7dRnmxVezgzE+PyhgPTRFaeAD7IsXtMymJTQ6uyD gA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfwu7vgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 11:49:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318AqlkO020103;
        Wed, 8 Feb 2023 11:49:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtdc9hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 11:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0aAzwphYn0g9OERD8mrNo9bEwi4gS2TkImgaR59VxW9II3nlkIDpeFvrWTA0Li6sVf/QTlpxMLFSWgiKYjxnZ6fq/1meY8sTVdGAAJIgryiTaXqHeKVUZvpXUllK4JFcXcVmF0Sm1OfbOb8Ra9iqMGkhP2hc1e01HOEV5vp7GfgSmgt89JOYEV+xGX3rQAtiRIlmJGtJ1mSaLGtHU7CyyC/j0+bnVpdP7++5QnI0WMYvLfKIF4wU9Ek4MjN7vt9OYCV6mmto1anDTgwLaGqhTPYFfOMaf4ShOf3EKziVBXOobsrnbHLn+69l1PSOkGuJNCDHQ5VycfEu70r/eO1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35CkJnXJUwgQ5kg9tw1KXqQ4yfFedf3spxbaiQ0jPbs=;
 b=QyBhHo0GHsj11wZqJyjAe9lbaWdnL4v1FOhCdvfD4FGF+yDGbeBv0YrzulJo8RZeZgED2T2rmQQmWClD10uJi3QsUiBmtooAZqEDQBS5w2egQsIrE+sd8n5oMfT7uovq/SpELYU2Es+vB6BIwckeXBPrJGX/r9B2TatC2SfsTAH+ror2pVM8tHPTTp0F0CoeNTIVQlEJZ69iRSOZ2oOBZ/BuF62UVNVFNTtxGPryspiVk+aR0elTAnvCAWwnQ+1Yxw+W7eiQFsPwSDwixDvyvTeQ4VwcLW0FYPBCf2VLcxKe0NZlZyYhuBrFSA7/SIoY/Vs0rVNO46RG5q2Kb+j3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35CkJnXJUwgQ5kg9tw1KXqQ4yfFedf3spxbaiQ0jPbs=;
 b=MyZzPvqFXTgGeIYOctfFNx363cIvUHPysUJAEKZGERQAASFfJIxWWigx+QZ4No32Cz7cIXgar+P4AeK1L5ZZONZSmZ3jTUWgreMI7khbN9DCYhIMJ/s5XVwrAGHDxiPpcFdZqO4rvX1vzyoTu2Z6HubVQGvA7u/wNwWJgKBR1yU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6774.namprd10.prod.outlook.com (2603:10b6:8:13c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 11:49:49 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 11:49:49 +0000
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add test for legacy/perf
 kprobe/uprobe attach mode
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Menglong Dong <menglong8.dong@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
References: <20230203031742.1730761-1-imagedong@tencent.com>
 <20230203031742.1730761-3-imagedong@tencent.com>
 <CAEf4BzYh90NyyYvfTT=M=-KLspydMX4PZK8jCwNDydAP=kFgYw@mail.gmail.com>
 <CADxym3a6_wBHW_c_ZYtZ5QXbbunhKxau6k-fn4TNrn+6qzW6fw@mail.gmail.com>
 <CAEf4BzZAo6Bfio3pbY3j5yUDArCbdiWPC-r=XhFM9Bwq+4VVMg@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <75421c53-fa5c-d7c7-4b19-2d97e3e6d7f6@oracle.com>
Date:   Wed, 8 Feb 2023 11:49:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAEf4BzZAo6Bfio3pbY3j5yUDArCbdiWPC-r=XhFM9Bwq+4VVMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0095.eurprd03.prod.outlook.com
 (2603:10a6:208:69::36) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: dadae1ec-2e32-48ea-1b0f-08db09ca94db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mMer6aHJbzsm92GV2hJTD1LHrL4l5IITqSDDLtk3IJLqjN8A/1K2ZqEJzjmF6RxIuDLaXDnJzptKiOYs6ZpDInGZzZOOCSjXqVN9+WU0SyOYDsV9HC3T2DhZ+9k3z2imUo7e9rZau6vWx8Ry5YZtlSI2xEtHe9fVN/Ux+0e5nqbkHHsEjMdQWC2SdDT4b0xrNWn8dEmt3/JGerf0pql0p4axinrB/jv1wi1ZTGpG11LNyvcIC0q8FMxJ79z+45U085Kq9IIO0TAu42lz7AgLJfodiZU8SjJI5PUEhZHxi44Bgi3a/3476I1lJeYSTpsxwATjantiZ9HAyb3ciQU5lzruPQeQwYHTz8mzpixnLIcCQ0GQjfia9PsTRP1sk3wJxcTbtKX4SPsVAyLxzWP2SaFE6PDGtQhehPGdhcjT77/o+Cn2KFzhxoFvXpwzk88pVpLfPWcxz4tF9dYPScgc6rnrJIWquGaFMm0wFcRP5kf2y+UdguPk0+IoAF32RUdpzJ/+M6o/qaoEvZ9Y9uNLsr+HemPDiVPhiEV5ADEA2lvCFGtlh2Xyjw+6kBXxVxo5zQX55VDXogQrKQTC3jBy0z9ds2avVDz6P18N8gnrwnWrgt0QjVY8pSudaTimG3FPwZcNxau6LVJEUJh1R2/lhlrdSZMkJXOtMedVM2fRnxLOdFRT/LYIkQpK3IWgTYIEa3Fog6Dh6x6LXqJ1ayuCE34thjhp7Qp/iBen7qWJJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(31686004)(316002)(2616005)(44832011)(110136005)(6666004)(83380400001)(7416002)(36756003)(186003)(6512007)(4326008)(5660300002)(8936002)(8676002)(6506007)(53546011)(38100700002)(41300700001)(66476007)(66556008)(66946007)(86362001)(2906002)(31696002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHpmanFoMnJCUU5DV2lVSE9pRElJY1RlOFNsVC9uV3AvMkdHaW1UenBob2lC?=
 =?utf-8?B?VXNyTk5DM0szT2FiUG5OankxakkvRGJRZnc0ZDZtQkRHR1BwMGJ5eEZZaUZN?=
 =?utf-8?B?dHpLYkZwVDdjTUNYVjBoUlJxbFIxeDlTd2djcGNVWGN6S0ttQUlUQjBLdW4r?=
 =?utf-8?B?eTVRcDJSRGg3L2hnSEd3ZUdRY3ZWZUppNkJ1T0RTOEYxVGpaZXR4VldIaHkr?=
 =?utf-8?B?Z09KbFdmTEwzb296aXhMQ1JWNmM2bmtJQVFHTU1mZmdzS2dFeHcxL3hVcFI3?=
 =?utf-8?B?ZE8rNTdvU3FyRXFQTlhyaGRTSy96Qk5ZcnNHSE5wMEV3VDZWa3djd3RRUHlQ?=
 =?utf-8?B?TmIvVlhma1h2elg3eUxqNDhnbkxaS1kxU25ZRVNWNmRQMk84Z3pNK2I3Mm1s?=
 =?utf-8?B?VVg0UVEwcGp3UmZBa1ViLzQyS0xPeWRnMnNqNnVvejkySGJyMGNBZm9xWXor?=
 =?utf-8?B?cDRoRHEwQ2NGeWp3NXhCVnJ3SlhIeHNGQjJHY0JzdDdnU1ZXZmpjenlxb1d3?=
 =?utf-8?B?cUtyZ25JRVNvZFBTZFI1REE5MHZNKzRIMHd5RVNYQ2Q5OXhSMzFId1BGVGNK?=
 =?utf-8?B?NDJzcVR4SWpvOTF3dUR5YVpFTGpJT0R0aGdIQ2Q1dFV5NnFOcmlvamNtWnlo?=
 =?utf-8?B?WGtMZmVsTk5HUnhKUmozRVRFZXFTZDExbHQ0YlE3WFFWVndNMWVjUXovNUh6?=
 =?utf-8?B?TU5UYlJ3UjNFdm5vZWVFbmp2RXVXM2J3Mk1tTDlDM3d2d2d4cFhDRHhNK1I2?=
 =?utf-8?B?RURDUE1TQWl0N0QvYURzS3pBNEQwSVRGZTBWY0FTVStlekxPQXNXa1l6UDhj?=
 =?utf-8?B?eTBNaVU2NFEvS1RIbUNLU0ZjRnQ2cEFRRFoxK1VmV2JXMkdiODE2VWhyYUhE?=
 =?utf-8?B?cHNaeDlndFhRQ3NuS0xpMXJFQWhxVHozQVgzM1p0aDZqRzA3MW5RU3N0YmtK?=
 =?utf-8?B?VnBaNmk1VlRqNGFobnR3VHpkaGRTb2Z5V1Y3V1lzV3VTNkhUa0phMytaUlc4?=
 =?utf-8?B?V2hmOGRIWmJ2Y2JFbkQ5dDJCTUVwWnhNOStEL1RLT2Ntbm5haGY0VE1SVDlI?=
 =?utf-8?B?bHF6S1I2TmdmRk04d1VRRzd0RUpKVlp1enhmNERRUXZ0c1dsQnpOVXcvM3VK?=
 =?utf-8?B?Y0NJNUFuem9VVm9MazJucENCL0Y4d2t4M0VmQjUzSXJwUlJ3enFlck9kdUxj?=
 =?utf-8?B?OW1QdFhycnFJY1lwbTVwbENiaDNYcGlhaVIrVXczUnNrTStFb01iMnNnWERM?=
 =?utf-8?B?SVlBYlhBZFZwZ21LOVpibllOempWTDZvMFU5M1Y1RFQ5cWg0VUFnV1QwOEVS?=
 =?utf-8?B?cjJZQUd4Q3E2cnExRjlzalRRSnk1bjVuL05razJvbE8xYkxwUHRFaFVTN3E4?=
 =?utf-8?B?bENaTmlZaTFPTXhDL3NPYk9EemdZZmVDVnBZL0h0UGRMYjFycmhYTG9VMWJT?=
 =?utf-8?B?cmJ6aHRHY2ptd2lnQmF0Y0xPYk9iS1RJVkdxa0J4RUdTdWYyODJheGhwdTZv?=
 =?utf-8?B?ZEVFTERxbU10Y0FIY3ZXNG1YUWtpNnZ4cW9WMm5Xd25TRVdib3loS3pDU2pz?=
 =?utf-8?B?VzlvVDhuYXoybW1OeG5OaGhlYjdDOEs3eVdreC9Vb2h1a2lRNmh2dnJBRlZC?=
 =?utf-8?B?UWxadzNacDUxc0JzNFdMSzBkNG9Ob2dwNkJrS05INnZYR0lJZVhabVdxR2cy?=
 =?utf-8?B?U3ZlMmdHV2tSYTF4N0tPNzJtM3ZBbW1ORS9ySXBSUDlHL3Z6VjlQcDZUSzhT?=
 =?utf-8?B?bXB0bWZ1SUlrMzB5RmlHQ1l3TEttanFzZUkySjJGYkNyeXplRkVrd1JSWXZv?=
 =?utf-8?B?OE1ENTVIY1FjTmc4KzQzcmpPUWVtaVF3YVFCOUVxQUNUdEZIdzRUM1BubFZZ?=
 =?utf-8?B?amhZU2didHB1L0Exc1hvQUZ1SzBzV2IwRWt5ZURyekROdXlEaXFJMFBiaktt?=
 =?utf-8?B?ZGRwVzhlc0tCWGN3QWlNOFM0dDh2bVErSUozWlFtZXI4SVpQZ0MrVXl4b1lC?=
 =?utf-8?B?VlRFL0tDRDV2MlZRUGsvaENiZTdsY2RhbTNNTWZodEtCV3NoQUhGa0wxYjRt?=
 =?utf-8?B?ckowQ2p3TDVXb2ZabThhYnl1cUZTUGdvRnkzOE5JaEhKTjZiYzlhc1VZcmhk?=
 =?utf-8?B?cjZFUVVkSnN5SVJXMDJVZ2VJMUg3azUwbHB3YjhtVCtCQjJvL0Z4enpUWWlm?=
 =?utf-8?Q?BI3zhrd9mYTp7n5qk/7Gjwo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QUtqcXFvWTlsTHRsSDQ3OEs0ejk5bjhrSlUyL0hSRkYxd1YrTkRjYmxGU3BM?=
 =?utf-8?B?MTVYd2JQZ0lycXVZVi9NTnBMMXVoYnpFZ0VWSUdBaVhUc2pNLzNvaUhjMTIv?=
 =?utf-8?B?R1A3L1cvbW9CdWVYUEhaaC9wV1VzOVRJYTBraVZYd1pRcWhGbEdRVDlobjcz?=
 =?utf-8?B?T0pHeFhJczhBdkNvdFhadlRTdzQyaVJNbFh1Rk4vTjZ5WHlHSFluUXpsakU5?=
 =?utf-8?B?QW9jMWx6MEFlL21SbVptZThmWG9GaDJpOGZLRDN6L0tyNndaSXNOTnc0ZENK?=
 =?utf-8?B?TEV5SWoyeXJRUHRUeVBHOUFNMkY2bm1CU1VHcUxXZ2NONkQ1NnlxUGc1S2xB?=
 =?utf-8?B?UTJuVmMrZ1pvVEplclFMTkdzenIvZ3JpamdPQlBlcktLWGoxWFBINVRUUm56?=
 =?utf-8?B?OU1uUGs1dWw2RklMMWhkWE5LT2lPZEVGM2Fiek0yc0NkN29kK2VmWTRiUXRu?=
 =?utf-8?B?TXFJZC8zQ1FUc2k4VktlSCtkTnFOaTlEL1RGZnlDbStDZEd4dEs2MHcyYmdk?=
 =?utf-8?B?cnM5dkFzU2Nxb0lSaU9Fb1U2dllzMnYvSWxNYzlzM1kzV1JmVUE5VkVuRGZN?=
 =?utf-8?B?eXNscHZ2Sk5zWlRvMGpxcFVQSlF0RHZEbkc5ckNlc2M4ditBRUFodkdibXNo?=
 =?utf-8?B?Um96dTJIaklzNXFDUlVUQkFWMS9QQ2NzSG9FSGJoeExIclA1MHdGM3JzUTl3?=
 =?utf-8?B?cUFMT0hIZndKR2pDV2V1ZGMvcmlUd082cjFjV3BnZjM2cW5md1RaVEtkT1pv?=
 =?utf-8?B?V0lKTEtqQ3g3T1p3R2NqQWprMmIxWEUrL2RpdDhBTnhEUTRUVEYxWHFOLzA1?=
 =?utf-8?B?V1UvbnIrTGxya0R5aHpWUWRWTnlFdEhOL083MDRhelJQM2JoTzJjWklMcVRH?=
 =?utf-8?B?K21JT1d1SmhtSzI2cGpwaU44b01tdFFHZ05hdUZHUkc2RE9uWG93S3FkQXh4?=
 =?utf-8?B?b3dUKzJXNUJlanlabFBnUkVOYkszUUZQb2FPb2tsVjduUHltaGVGeHZ4ZUxs?=
 =?utf-8?B?TUNpdGNTS3Nia28vWjNDQTh0ZzdFd2piUDE4bFM1T01zUkZTVHdyUnA4ejdk?=
 =?utf-8?B?QjlmQkV3blpQbTBocDhMRDVMYm5GajQrUEpwY0xUWXU1cmlyeHpNTGhORjZy?=
 =?utf-8?B?N2VqS3BVclkvN0psSFdsbmg4NlZJY1d0WENPL2NzUDRUVFFjM2wveForUHFE?=
 =?utf-8?B?L0lDR3d4NzR4TURrdE90amF5WGdoR3J0UllOd1g3OG9pVzRhaXZFR1lGMFVP?=
 =?utf-8?B?bWZESWNaTmxpRk9YVTBGQ0p0aTV1K0VQZElTSjBHS1ozaUc0QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadae1ec-2e32-48ea-1b0f-08db09ca94db
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 11:49:49.0206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiY/RTCYg7Tpd0OxVe/bkgIL0OtYpM8Lts98d1dPiL5PDWdGSQw/3g8AdLlO0kKzsAxayG0LcKuqzmfHwYSiFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_04,2023-02-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302080106
X-Proofpoint-GUID: HneKCyMmi9WArrPrR9v0aEbWPasPdouJ
X-Proofpoint-ORIG-GUID: HneKCyMmi9WArrPrR9v0aEbWPasPdouJ
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/02/2023 22:50, Andrii Nakryiko wrote:
> On Mon, Feb 6, 2023 at 6:39 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>
>> On Tue, Feb 7, 2023 at 4:05 AM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>>
>>> On Thu, Feb 2, 2023 at 7:18 PM <menglong8.dong@gmail.com> wrote:
>>>>
>>>> From: Menglong Dong <imagedong@tencent.com>
>>>>
>>>> Add the testing for kprobe/uprobe attaching in legacy and perf mode.
>>>> And the testing passed:
>>>>
>>>> ./test_progs -t attach_probe
>>>> $5       attach_probe:OK
>>>> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>>>
>>>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
>>>> ---
>>>
>>> Do you mind refactoring attach_probe test into multiple subtests,
>>> where each subtest will only test one of the attach mode and type. The
>>> reason is that libbpf CI runs tests with latest selftests and libbpf
>>> against old kernels (4.9 and 5.5, currently). Due to attach_probe
>>> testing all these uprobe/kprobe attach modes with extra features (like
>>> cookie, ref count, etc), we had to disable attach_probe test in libbpf
>>> CI on old kernels.
>>>
>>> If we can split each individual uprobe/kprobe mode, that will give us
>>> flexibility to selectively allowlist those tests that don't force
>>> libbpf to use newer features (like cookies, LINK or PERF mode, etc).
>>>
>>> It would be a great improvement and highly appreciated! If you don't
>>> mind doing this, let's do the split of existing use cases into subtest
>>> in a separate patch, and then add PERF/LEGACY/LINK mode tests on top
>>> of that patch.
>>>
>>
>> Of course, with pleasure. For the existing use cases, we split it into
>> subtests, such as:
>>
>>   kprobe/kretprobe auto attach
>>   kprobe/kretprobe manual attach
>>   uprobe/uretprobe ref_ctr test
>>   uprobe/uretprobe auto attach
>>   sleepable kprobe/uprobe
>>   ......
>>
>> Am I right?
> 
> I haven't analysed all the different cases, but roughly it makes
> sense. With more granular subtests we can also drop `legacy` flag and
> rely on subtest allowlisting in CI.
>

I'm probably rusty on the details, but when you talk about subtest
splitting for the [uk]probe manual attach, are we talking about running
the same manual attach test for the different modes, with each as a 
separate subtest, such that each registers as a distinct pass/fail (and
can thus be allowlisted as appropriate)? So in other words

test__start_subtest("manual_attach_kprobe_link");
attach_kprobe_manual(link_options);
test__start_subtest("manual_attach_kprobe_legacy");
attach_kprobe_manual(legay_options);
test__start_subtest("manual_attach_kprobe_perf");
attach_kprobe_manual(perf_options);

?

>>
>> Thanks!
>> Dongmeng Long
>>
>>>
>>>>  .../selftests/bpf/prog_tests/attach_probe.c   | 61 ++++++++++++++++++-
>>>>  .../selftests/bpf/progs/test_attach_probe.c   | 32 ++++++++++
>>>>  2 files changed, 92 insertions(+), 1 deletion(-)
>>>>
>>>
>>> [...]
