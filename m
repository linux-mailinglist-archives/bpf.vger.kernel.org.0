Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B354CDF6F
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 22:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiCDUva (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 15:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCDUv3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 15:51:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101C1B45DA
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 12:50:40 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224K9IwB019116;
        Fri, 4 Mar 2022 20:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sAeyK6jqXXIYFQhoX4hStuZE5E7XoEbWPXT/PQElWkY=;
 b=wCOtx1rFfXkK1FoUeVSgOYMeCziIqCjWmSpes1ZZQGPLAjKSQRLqsasFwsokBUEpuZ6T
 EQXH9SjvH73+a16YRrR+iafyTm8c96luqDthklf2n0yxVO17NNz7o7RkyT9ZRIZcj4k6
 dvOBNZbpnxf061eGm0FNK50s4sAi9getWesDBSM+EWvQCGJBs1tYHYNRdohghnmb7wkf
 f5vjpA6E8s7hmkzXKhwAotfSnT3s11gpHCl2nN6uSvPhRdL9w/uYDi6IIWI6elgEjc/u
 Mah//cb2jr8w51VEejfIrbbZrRKSru5LLVdj/Hu2N7Mg3t7PMXxtgkB1oPvWrQQknga3 YA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hvat52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 20:50:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 224KfhdV096835;
        Fri, 4 Mar 2022 20:50:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 3ek4jhdqfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 20:50:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLHFOh7UkmpuN8X0o7KjcWIrSNx4DLUClQbpziWXwt6o2UCR8wTHK5TI8lU7JLK30mhvPVxiKNSGF8qJP5tuslxO4JQNtZQU1OMV4s9Ffg2a1doXn15Jddr5oZnApHDOAMfPxJBBVglqCe2nkkpZVgAdaBygM3CZ0PCPwoohw74YAo/bcUG76e19smRyptHHS+P/aTel5aRv8s21zwtXcZZAv4UPvOmEijtM8yrLHkd4eACUKJlWRNtxqicfS6OutkkdZo9cM8UeG3m8UHJiVU2kf8wOr7e+yRXTq5mks6b1H3lwdPiH4g0kzPI9OXI0pSp4JDMtV1IMYfOODU+1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAeyK6jqXXIYFQhoX4hStuZE5E7XoEbWPXT/PQElWkY=;
 b=C2X6Op7zlAuqMelrPvKQ1DZNtPbqVUyY6GnBucsp7dAmbSNxoP8fqsC9sOHpqwh0SPEO2ZdTkSmbQ6tsHElVPSNMKYp6UtUMVHHg42/u0O2I7NjFrYeojbzgKdzP0joCug0dp923RtDp0BSeVCmSXomsMeWa+UsG8/R9UrxTltek8kfDapS7wDkufbHLavy+5XjuQr2HWkjYX+dQIIHBNSDC/qlYpM562nlWmhxuJXkv6hMWRKJ1fj8PIKtS630CY1PzhU6xm95tEfENoosnBEkkHTfAB6jX5nHCZzHKl5U06cKEV50+6MDE9zFXmtrRQJ9Q7zYXcU2FS+VHA2YAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAeyK6jqXXIYFQhoX4hStuZE5E7XoEbWPXT/PQElWkY=;
 b=k6D3ZFru+U/DwodxXbcTxRCRKClcWD+J6njskIvaK+yM+N42wlr2k/BjzcINhMSzdtrLr/lCB6EkypN/7FiCS51UQSb+ZpDZAEXobPlCE6pgIuPA8p7fbh2aein8TCI9qVEd8+0Wu5U5JJuL3SqazWHdHOTMSzMgW+DqYB7YuvE=
Received: from CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24)
 by BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 20:50:29 +0000
Received: from CO1PR10MB4644.namprd10.prod.outlook.com
 ([fe80::70d1:7ed8:fcb1:ed1a]) by CO1PR10MB4644.namprd10.prod.outlook.com
 ([fe80::70d1:7ed8:fcb1:ed1a%7]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 20:50:29 +0000
Subject: Re: using skip>0 with bpf_get_stack()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
References: <30a7b5d5-6726-1cc2-eaee-8da2828a9a9c@oracle.com>
 <c65ac449-ec54-3dff-5447-8a318001285b@fb.com>
 <1b59751f-0bb1-a4ad-6548-2536e60a80ec@oracle.com>
 <4e2e5738-b103-d340-753e-7e37e06304c4@fb.com> <YiJ4jTB8siLwxAEN@google.com>
From:   Eugene Loh <eugene.loh@oracle.com>
Message-ID: <76a70706-2d42-b1d1-1be8-5126c442194e@oracle.com>
Date:   Fri, 4 Mar 2022 15:50:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <YiJ4jTB8siLwxAEN@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BY5PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::19) To CO1PR10MB4644.namprd10.prod.outlook.com
 (2603:10b6:303:99::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c971c973-41c5-41ef-95bc-08d9fe209e3e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2869B9205525D067DD398318FF059@BYAPR10MB2869.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBMmdMSIAHtNY6fiqewsFDwy7C8pBie7xOB3sRzSMgW5c9K/TTz2dLAlBDXASokjAffUxq+wAhfvqqt9lyH8sR013a7ClPm+zhghOo3imaSOMr76U0O/MUTZ3PlLXgzMMwuKJvbaiAXDWi51AddgNdGn8ljuJvR9UaY4+IX2IVJr84URtnMwMcIm8XyDFmyqVMLLFoZACn6dvevYF6Vo2cZUPDTrCM13EQkoN9dugYaPhQun4Wo/IeR0PaQU3q5HRRVG6kXcJ+fZlx/rT7/6/CGUm/APAWIpP47ZEhBsZWDda3jwCyJwOLmubZAi5S9nK00V0YVJ/a2kAPSxxyEAwyL31C3Zq2I9OXTAdb21h6Oz8+W+SoZJaQhBFApaRhQPG90dbLC1HEzaGhUabsbUhK4Q6QWz5AAc11k6sYqZ6NW9Rni26eb8XR6458TTmD6decfGWWJt1C4RA6Oy1Vl1SdqUqbE+TiIOBqNKHezAgRbVUC4kkvM9ysEh+mxqhKl4KY6Ommz4DwObwanM4l8ekOKJ82FxbW/pi+LqSnxBweVnR558oP8PM/eTheWzot1tu4c8EVaVKArIgpQVd67P2R187/FW1Qo3aJ6Tj6yk+4G/9+gsTCfAd//vs46V3fgnrezt0i98Nt3mSsdrOXIia5Klyvp3YhZAuyAsN3QlcnukVrE0B/M+vEywVgW7716JRSxrV9k/G428MnV2QXkcNGnhl1CprdGQ+6NhIAK0t5HvaEOGEB2mUtA8ls09qNGokCgefXBr2SFpZj7mGhLeVzrfv33IwkrPqRHNq8j9t9rOhzv0YHB3Xhee4gL+E7E7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4644.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(83380400001)(316002)(8936002)(31686004)(6486002)(66476007)(8676002)(966005)(4326008)(26005)(86362001)(5660300002)(36756003)(508600001)(44832011)(66556008)(66946007)(31696002)(2906002)(6512007)(53546011)(6506007)(38100700002)(186003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGZyMEZBdi9URXF2NjZTK2tETkJVRlVQWUZ5U09vb0l0YlBnYUxDVzBRQmxF?=
 =?utf-8?B?RTJuMll3TDl2QkFvY1U2N2dtaEdjeVZVeU1ybHVsQUh0dmlCbGtwY0U2clp1?=
 =?utf-8?B?SHRtcVhCSHBJaitKVFVXcFVtNXpKbURBc2FwNUY3QnduUFpaMVFsSG5la0dR?=
 =?utf-8?B?NFFwM1ZjdEV3Tk5lL0lYQWIrMlYweE00WHV4OE9nWVVvcXZmbHhCTTRDOG1H?=
 =?utf-8?B?eGN1QTViNHJyNEtjNFpEcGJYS2NaMlFScjR4cTIya2tZVjUvNEViSlQ3cG5D?=
 =?utf-8?B?aTVCWDFIVExtaVFDUWlZUlgwZmVKY0RyWGhjT2hIQXdUYTF6bGlla2ZVRVpr?=
 =?utf-8?B?OXhneEIyWlUvdElvQ3l6YjB4VlhrQktXNDJZWEs3ZmJNNWpXY0lMWFM3b2pF?=
 =?utf-8?B?NE8yN2V3NDA5TDc3empDa0kxdjJsSmdkU3ZrbTFRQVZtVFJDU1dkNVlObmpo?=
 =?utf-8?B?MnNRTGxMTm8zUVB6WGYvUldSVVpReTdWR0ZaaVZLS203b2NONHFTVk1kUE0v?=
 =?utf-8?B?WldZem1xK3o5TDIyaElJbU4vcytyTmltZVZKUFpPZG10RUUzZHVWbHlFL29a?=
 =?utf-8?B?b0JEaUV4amRoWjRJNDhoNHBnOWU5M0xUM09sOFZuWjRyNGQrUEEzV0dPNWhv?=
 =?utf-8?B?STEyWVBObDNlNGMvYURObjIrMHN6Z2QxZ2k0ZW9vUFN2eFQxaEY0dWZZbFNt?=
 =?utf-8?B?KzdFSkVVbmdrUXFNSm1MZktMUFA2TnB3aW9nRUlaaGNyenNlTE0ybjU3WGIz?=
 =?utf-8?B?S2FWcXlYMmIraDRINURmSnYwYXViS2Q5ZDl1TmdqbE94alRHMUJEVEcwdVdr?=
 =?utf-8?B?TVpjaTdMbmV2NzVwcytDcGNLaUxENE9idm9LdndEYm81NVZ0TVl4SjUwdVo3?=
 =?utf-8?B?RHg3LzZiakY1THVyZTBqeEJ3UWlERDV2c3F0QlcrQ1h0WThnc3pYL3h6UVhr?=
 =?utf-8?B?TGZ6aXVqSi9zYWgzcy8wWW5hamxhU2FBMm8wcU9pVG5TankwZ1dFVUxvRmd5?=
 =?utf-8?B?ZlgySWkxektpTFVqTjFWbWRiOFRKdEthS3I3RHBXMENRRmNMZFl1VUtrZGEr?=
 =?utf-8?B?cTd5d0dyYmljOE40VFo2dVBqb0ZMcUxhUWxsVEk0SlFQQTg4VTRHQk9oRFV1?=
 =?utf-8?B?TXp3VkU5c29udjg0MTR2bzkwdXlTOEEyYVhUNzJGQ3NQbkRlU01Wb3Y0OFpW?=
 =?utf-8?B?VFo5RXJpOUpuZGtFb2RWT3NnOHhNRk1SSnhEV0hGTGJ3ckthcUQ2Rm5sU0Vs?=
 =?utf-8?B?bGZJaVU1TnQ3cS9vN2VCZ2FuYzJsSEVGWTRQbTJxMGsyN1kwVkFlb2hRV3Aw?=
 =?utf-8?B?bUs2b2cwNjlxWXlxeHZCNWxFT0JoTFFNd1pCNi9PVUQvSS9hQ202ZTlvVEpD?=
 =?utf-8?B?cW5Cb1JBV21tam0wSVNBRC9aSnhSM0t3ZjY5OE4veTFoZEx3OEtpVjNkalNK?=
 =?utf-8?B?blBTQXVRRERvaHJxR0lnZjJoZHp0VFF3TGJJUDJJQ0pIelY2aFFuL1FuTnlE?=
 =?utf-8?B?TS8vSFRoMWNjNjRuQmlDNjZLWHZGQS9YdTFvSFhjZWovcDFneU92ZzNoYlpI?=
 =?utf-8?B?OWllQURmSlZMa3cxaXNIVmdUVlhGYlUzZWhoVzJ2Zm1hMkdQOHdoUTFBcVdz?=
 =?utf-8?B?ckxUUjE1YWR3akNGS2dTNzNJbVR1cXRtRXV3cHVQbk5PMTFkTjFpVDJPMWYy?=
 =?utf-8?B?eFZmcEJKUzQrUWRKYjRsQ0poWmh4UC96TndmblVoUUN3N0Jzbnc2S3UvcC9m?=
 =?utf-8?B?UTQ0eDJFVWwwV3B2T1pWRWViZ0xxRkIyc0dDUHEyMUlxUzZGa2kxWk9MaTFW?=
 =?utf-8?B?dEoyVnhMOHhibjRBdXFwNW9naHBUeW55QWJHQktjeldpY2t3YmxDbytPWHZ3?=
 =?utf-8?B?dnRlQU5NZ2lUeHYxZ0MwMGNHTjVncWpHZ0VIcEwrV0tTbDc2cU8xeEpmVTRC?=
 =?utf-8?B?eW1HRjdja05GZEkzQlBtR2l2ZFZWZ1BEQ0NyVzRZcVJtelNGU1BWaDQzaWZz?=
 =?utf-8?B?bnZlMnpDQXZtZk1KcThtc0ZyMHF1c3JWeUwzRHhvN3kyUG52blBNeUNwYVcv?=
 =?utf-8?B?djZiYmJMTFVQRlQxb2lHQk5rMG43UDFmYU9heDRmR1ZpZm03Wk9JYlhUOVR3?=
 =?utf-8?B?dVlKMDRtTzEzTHR3TG53K0Q1MUdKeVBRTzQ4d0pKSS8vTXpVaityMElHY29s?=
 =?utf-8?Q?fqrddtB+o36wV8P6sooNbuA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c971c973-41c5-41ef-95bc-08d9fe209e3e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4644.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 20:50:29.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmOI2/eVMFa2BYAjE2Kw8hHX7QEo7+T4DPkdyeB34SNCvwKBdpuBGhiuZPG4z+moVJKs09eja9haySLHxzzi5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2869
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10276 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040103
X-Proofpoint-GUID: aHOnG63OaEpje0ofA0ItR9fUDqsgBHD0
X-Proofpoint-ORIG-GUID: aHOnG63OaEpje0ofA0ItR9fUDqsgBHD0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No update from me.  A fix would be great.

On 3/4/22 3:37 PM, Namhyung Kim wrote:
> Hello,
>
> On Mon, Jun 28, 2021 at 08:33:11PM -0700, Yonghong Song wrote:
>>
>> On 6/25/21 6:22 PM, Eugene Loh wrote:
>>> On 6/1/21 5:48 PM, Yonghong Song wrote:
>>>> Could you submit a patch for this? Thanks!
>>> Sure.  Thanks for looking at this and sorry about the long delay getting
>>> back to you.
>>>
>>> Could you take a look at the attached, proposed patch?  As you see in
>>> the commit message, I'm unclear about the bpf_get_stack*_pe() variants.
>>> They might use an earlier construct callchain, and I do not know ho
>>> init_nr was set for them.
>> I think bpf_get_stackid() and __bpf_get_stackid() implementation is correct.
>> Did you find any issues?
>>
>> For bpf_get_stack_pe, see:
>>
>> https://lore.kernel.org/bpf/20200723180648.1429892-2-songliubraving@fb.com/
>> I think you should not change bpf_get_stack() function.
>> __bpf_get_stack() is used by bpf_get_stack() and bpf_get_stack_pe().
>> In bpf_get_stack_pe(), callchain is fetched by perf event infrastructure
>> if event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY is true.
>>
>> Just focus on __bpf_get_stack(). We could factor __bpf_get_stackid(),
>> but unless we have a bug, I didn't see it is necessary.
>>
>> It will be good if you can add a test for the change, there is a stacktrace
>> test prog_tests/stacktrace_map.c, you can take a look,
>> and you can add a subtest there.
>>
>> Next time, you can submit a formal patch with `git send-email ...` to
>> this alias. This way it is easier to review compared to attachment.
> Any updates on this?  I'm hitting the same issue and found this before
> sending a fix.
>
> Thanks,
> Namhyung
