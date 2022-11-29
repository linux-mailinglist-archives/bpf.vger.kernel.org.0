Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461DB63C534
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 17:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiK2Qbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 11:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiK2Qbg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 11:31:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E73468C44
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 08:31:35 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGPo15012293;
        Tue, 29 Nov 2022 16:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uc7qHrk0tItCdoXGbdmIk6xnJdSKVAIQ+8oeS0ecAeY=;
 b=DaqYvO8/NoqmGTR+V9uVzaIqBCss1EjvpzdYBqKAKMMdP93NbUbLs/QzXT72iPHeC0c6
 sS7+H5ur+As4/KR6yO6nEE6ZicMK88B7F8W5U9pBXDcs2Q1+Is19LZk/EElwQ6wT4T3a
 FfpzrQf2Kl8oSgG8FfwfqYGxZ9qHxGLoYK+bh6fiWJB/F8VC0T0ixX1i6+b4Q4HTDrUy
 WVOTO7JCBTYrk1GW0XcwnPZ8nkEIip1D7PmBSD6Q56vRsgxXmkGE6aR5S3aGBPwojzBY
 jVnjP8BGNoiv5TDVbNIX96RngdfReR82D9Gr5V3Rx4rV6yV3fM47bqigjZ4fzivr1YS0 /A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdkh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:30:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFfUtL019254;
        Tue, 29 Nov 2022 16:30:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398dqb33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:30:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2WW/pmjUL3SoHeb6ENbDBPpMHoQiUpc3zNT/XmywZkLeC2L2fdLNvRH72LX3M59gES4eCehEXhRgUEhL9DWKYKV6NgRSscfkeCYQfqQGtAHH6SZliTrpzIdYAWrmq3B1VSimWg+BKKP9EOYuJF10K82J3VkwJ3wnUGBBXNeIdSQj3NBTIMN/PAaTiKNNye0kfA0ehx2tGeW5xwsjpIJhOJ/KQ436/mE/H+C+53mdWcFdHJbjpkjU0/dFS9RQ2wj/RPXBdNHY/CQas/YoSDBy6UtOraSeatnqkSoTGUAyg4g23X9Ti9Z1D53D0my4tdkPMD+UXYcuMfOqB6udMmSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc7qHrk0tItCdoXGbdmIk6xnJdSKVAIQ+8oeS0ecAeY=;
 b=VDvjeckeCJ0wCO8PXeTCbI43mPX6FvUK/rGAZOv6x019m+zXV5Or1fAuN/xvHpIc7HB6f8D15+Ixf2f0zzGhO0i5c0I5NtYk8tyjm+ttkCZbJY4ipnj/HjpIEjC8ftJa9jPD7cCe4+n6dZ4TnHIwC4U7lILF4aEWbuCrt3uzcadqNfKBqmGuiguVcbRJPlLz7mOt9vJR0TJ8wThlcgW/Cy2ramf4ZBy2rp9qTSLxW7oSUWFtRl+QhICdLM3eP9b7Sxy230qTlDlVD/jrywP0Ej2Qky1Im015gG2RUpDQz9LteckoD6htgPPPAPy8lDk1pAE7C9RvVYSqzCbqTUhy6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc7qHrk0tItCdoXGbdmIk6xnJdSKVAIQ+8oeS0ecAeY=;
 b=P0dk/nGVcA2uzpjUhF+5bNQch3K3u2ms5MdYbQxhzSzpjU9SPVHVzyRofvY1+C2sAoWq9d1P7RCkuR8cxYJPns5lhhF7qxcmbcL2LPXJz/vBdqXEVzjWebwCK9ZbpPRuf2sE2LeWk7p7pnUFY6A7mtop/yCvvYqSIDh5Aa12dAg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB6414.namprd10.prod.outlook.com (2603:10b6:806:259::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:30:51 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d44e:a833:13b5:4119]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d44e:a833:13b5:4119%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 16:30:51 +0000
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Implement two type cast kfuncs
To:     Alexei Starovoitov <ast@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@meta.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221120195421.3112414-1-yhs@fb.com>
 <637ade2851bc6_99c62086@john.notmuch>
 <2c4f8cac-6935-2c72-cc1b-34a34708e127@meta.com>
 <637c2a6c4b042_18ed92085f@john.notmuch>
 <e727f852-7484-b31f-fb5d-7a4f034fe48e@meta.com>
 <637d911914799_2b649208da@john.notmuch>
 <13196687-fc16-f690-e2cb-f051aabae228@meta.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <340a47fc-8854-49d1-0218-202ad9c42bbb@oracle.com>
Date:   Tue, 29 Nov 2022 16:30:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <13196687-fc16-f690-e2cb-f051aabae228@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB6PR0601CA0047.eurprd06.prod.outlook.com
 (2603:10a6:4:17::33) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f58e65a-05f4-4b7b-9a54-08dad227141f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mt+KjSCBoBwqrRbAMzQGOHmO/rjRZAcp4t1d3dcCl4fcCZ777azad46NYXk6i9+05qT5clissZs6S4XVrOV90WPtIKisSoE5u7uRj497QLmY9M1cmfysqIWo6SQEJwt4fXiFKL+n8u6hAVUJvV3V/6CEhHJxVHWufekOeplQtYkif6O7IwaFw7WyYn4LX5vBebtmItFeZUYYHQJ2mHbeQHfaAv+ye5uVw8VcIGsY/1Dqgt6TlxLW8IdJEx9WWuYnuRwezZp48eLbj1XP+YWOwyZH5O5M5kw/Zocp2K202w+pr6HA+1pgBWSgdDifeR3DiAA+QYyBWgYdww6RWvXjOjYBP90czwD7UvRsS2ShSxoPl8OkkFmdzj0don8gg72p+rfdsa86J3CqE0GGtZZuPGAe0v8AO4rg57PPAkTI7sJVC3O/zyBeK/9j6aFCE5WTR0LgpkxSmfPJuHFlqGwxxA8ujsk7xJDWbom72yEeYELK0/JRZPAH8lyaIJyA3KQg1v0XZPkmOJEADq+HYPKo09yCSc/aABK87S5p1FdkB1lRaoAtd6EKFoD2uTu7Q+p1zX7R1prFbz4dFlTxEwj9Vg4qNipBCUar/ttKi7tak/4wMnXcCM0Rrs4c/uLyiAKhY6jWbrKYCkld4vRc0ijGxAOORkSHzAwmFdV6CsxiRjgt8qYMsA6QfT8zfV4u9j0Cz31sPYHIjgSjTMVPuFkDH/2g+9KZL/1ZD1fsjQtmmgQhfcrtTwAss0vsRRpgbG/nMa18J1Yc6Nc5SbY9A36fQQ4ewaWignbr+VnPL4S0Qi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(6512007)(6506007)(6486002)(966005)(110136005)(478600001)(53546011)(316002)(54906003)(66556008)(66476007)(4326008)(8676002)(66946007)(31686004)(6666004)(5660300002)(41300700001)(44832011)(8936002)(186003)(7416002)(38100700002)(2906002)(36756003)(83380400001)(2616005)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFVDYmY2TVVRaEE1bmpZNXloZlVJemt2QnVhalBIRVk5dWxOWkVyNEYyV1hW?=
 =?utf-8?B?OXVCWHZla242V2RGRjVVajhGaXNVRnI2UHlkV3dZL0k0Q0VNazdQNDVWbUZ1?=
 =?utf-8?B?Rlk3S0dUMEtwMTN1eUpZb0lsWGg3Ui9PKzRMK0ZiVk5KMmhGMXR0MHozQyt0?=
 =?utf-8?B?bGJ4MWdyRHE1ZGFWUWRvanl3dnFDL1VPNmJoWk1OTUExTi84dm9rbFEzT0dR?=
 =?utf-8?B?czZia3hzL3RuSUx3TU85R2lUQ1YwMkp4OFIrTjRwSjRkblZtT0tKZXI5U3lC?=
 =?utf-8?B?TEhzSGN0K2t2SGVqNWZoNEpLYXJicG1xRWVrUEJhV1VQY0lQdEFac2ppUHJM?=
 =?utf-8?B?cm4wTzIyR005WFJzNTFsa0szWFhnYXovR0FFT1VHdmwxN2Y5NjdMSjJzamxQ?=
 =?utf-8?B?UEM1dWlKTndlSlhyYTVkSlhSZC9tYTdPWXFQVDc5U0hyNFpLeTNNSUs3UzlR?=
 =?utf-8?B?S2JOR2dMUUFWWEtmYmd1dWh2T21MTktKcTRVTnlXTjRoVDVXVit1UFk1WURZ?=
 =?utf-8?B?MXRST2RQUHRUMi9uTHFqaldsYmFHZVBBenAyVWIvR0ViWmpHQW9nM3dKYTRq?=
 =?utf-8?B?OWlYTmZobmEwSHVEemlNclp2cHhHc2p5QTZqbXp3WXVGckdDQVZrVkR3TjJy?=
 =?utf-8?B?RzZsRVpOeUt6Q2pORStnL1AyaWtabzBseEtWYkJlZm9DRHg3clpUcFJzd1M2?=
 =?utf-8?B?a1hNUU9Sdnp1ekVOWFVsYmVjUU5zTEZWZ2N4THZhLzd0YmZmQ0k3QU5kSmIy?=
 =?utf-8?B?ckl5OUx1dzlvVndZdUxod0ZxZGp1VmlxQ1ZnLzZRVGRqVVJjS04wak00dVlQ?=
 =?utf-8?B?RGlwQTBtLytYMEt0V1daVHUxeFlGcUZKYVhjQ0lQSVdDWmx1RlBPaSt5UWtC?=
 =?utf-8?B?SVN1cnpJRWhiSUlpU2M1RWMybWdrSHVnSGxIOTJFdG9iK0pDcUtmb0VjMk9N?=
 =?utf-8?B?eXhkNlZsakFKeWhTckhIcEZKS1BPamkyR1oyS2kwUkdUTmx0VHNJMjBYMXND?=
 =?utf-8?B?NzBiSlFYL05VUmV6Y0VXODY5SU03Q0FJRUJLVS9vUDM1MFBwSkpuRXQ1bGta?=
 =?utf-8?B?VytRZE5tQUFTNEV3eitZdVpJcGhQS2RZWmZxSkNqdkxqZkpMMmxvaWZ2NUs3?=
 =?utf-8?B?M3Nad3Rhd3BtdXZFRVEvdWtTVzFPNzJqcVJ3YjUvb1FvOXUxU2VZN3BqS0pS?=
 =?utf-8?B?dVN1OUhmbDF6dUphcW5RYW94cHRpTGkvUzNqMk9PazlhV0lNLzB3MSsxMnJT?=
 =?utf-8?B?UWxmNFVOdkpINTZ5TzF3OWRVZ1dTdFFXM0RxanNpdVZrcWRHZzJjTXg1OW1W?=
 =?utf-8?B?OGdNMU5EbFFCK0h6SVAzamh4R25WKzh0K0k1WW9qMzJHeTF3aXV5UFZuTnIx?=
 =?utf-8?B?RVQ1NjZCblVQYjNtSmJQUkR4SXBrU3BlNUZ1WlNmeGlVaktHQ2lHVkFRcXZx?=
 =?utf-8?B?blliaHllMlhZWFQ3cHZnNXNCUnFkRllIR0RzWWh4WDBINUJLRWw2K0M4SXpW?=
 =?utf-8?B?MnNCb3AxQU9ySTBoRzRlTmtFaFRUbXpON0t1cExDQUJ3bVo5Tk0reEZIVkNu?=
 =?utf-8?B?YnFGNUl4cTdlamR3N0poVDdid2IrNGlrZ2hmQ2xmVjRDTWxacno5ckJuOWRr?=
 =?utf-8?B?cGhielIvbWRsRThoeVhYMGQyZXBWVVZvR0NsTWZMZUlkdWZBQW1OMWNvdE4r?=
 =?utf-8?B?RFc5SXVtTmVGRUoweldvKzgxZWdRRE5kUTBESGpqYk1JV2ZkV1VjMjNRZnpY?=
 =?utf-8?B?TXRhWHpuWEdMQmRQM2Rxa29yL0hTZjhscDRabDlSeUZ5Q2p0RUhUWnFrdGJS?=
 =?utf-8?B?Q3pyOVBLYVVSYUFxSU5WbVJQdEZ0SzgzWkhmNGlKZWYrM2NtaEx1RFNTeHdQ?=
 =?utf-8?B?bEdzV2xmbk03dld3YXVraGN4YzdScmJTNEg2QmY2WVQ2bVEzdEFQSWFsRjkr?=
 =?utf-8?B?NGJ0S1VLbHFtQUgyRm5zNHRMN2JUL29FTDRKWGNOdTJ5dW45T2tjZHVYbWJm?=
 =?utf-8?B?dUdiSmVYVGhsTFFtNC9jeTFxUTBXQW9SSk9YMjdqeG1Ld0V1QWZZM0QvK3dh?=
 =?utf-8?B?YitPY0hGNGxwVXNPNXlrazduaVRTbnN0aXlNSXNaZ1Z1OFpTdlQ1TzVzZE54?=
 =?utf-8?B?andFWDFuQjRvM0lTL0FCUUg5TDRBTVl5VVhMbjNLS3Zxa2cxOEtoUFRXWmFz?=
 =?utf-8?B?aXB0c0F1OVpRekxDZzNBY1YrQkl0dWpPK29zTC9ZN09SNXVZZk9RMFMzdjJI?=
 =?utf-8?B?M3BkUTV5d0NITG5VNjZnejZWMVVnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dkNYZkR4N3B4UHhlWDBVRWpMWjdabzRnbFF0a1RFQk1EWU81ZlFrRlV6aWc5?=
 =?utf-8?B?OTJYQmhTNGk0RVQxU1lRV1NUOEFMY0xNL3M4QjhVbGpBNGhEQWpENlNtenR1?=
 =?utf-8?B?bTlZWnEvU2ZVYWRKWHpNM2hETGhOOExHNkxOZXpWdUhzZWlqYWp5VVRnMjFR?=
 =?utf-8?B?SWxQWUFPNTFlZkwwK2FmTklRcUMrblV5YkMySExyYXovbHV5eDk5VldhRWQ0?=
 =?utf-8?B?c1d0VFgzK29CYXJNbnhDS1RlSzBrODZzSFUxQmtrbjFCZ2pIYXNra1Z5em1T?=
 =?utf-8?B?b3l5T2lWN3JlcWZjKzRQZWZMaVVXbmFJMVBCL2g2YjA4UExmMTNtMWswc3Qv?=
 =?utf-8?B?VHg4L1pDLzFNcTJxSGN1ZkE4RTBkTURYNEFtRGFnK2VsaWNLalpNN1NBOEZN?=
 =?utf-8?B?blRwdWRYWmRSUUNiRllHWTBSQ3ZQcDlUSk85ZDVrZC81UkhDazFVcTRmNWU5?=
 =?utf-8?B?YmJyMXYvTlA2TzdqRkZaazNJVXR5SFJESElmaExYL2g5cjJVL1dOcFZBeHZQ?=
 =?utf-8?B?UzFYUTNnd0diVW5IaDFhc2RFbzVPRkNYMURhZ3JsN3o0QitBRjRtczNnaGsx?=
 =?utf-8?B?eXU0S3FwUTRtNWRmdDJsMVNmenF4YVlBdW92eFNwdW9CM2dSRGlUVERCR1RW?=
 =?utf-8?B?SkVHYWRPQTFUa0k0b1YzcTFUSDlCRXFSaDdsbzAybHlnU0tzN1ZaVHUvY2Nh?=
 =?utf-8?B?ME5FUDlJekdjTVB3RUlyRlNRTGtGS1dCWmpiVkhKRmNsc1dmWW1ZeTAzT0xH?=
 =?utf-8?B?YkpYTHZlbHJyVDJYKytoMlRmNEllQnFmUVIwcloyRkc1a2o4WThUTEZKbTc1?=
 =?utf-8?B?YkdqRkR4YXJCWnh0OE9ZTUpzZnZYQmRsQ0cyR3J3MVJFQURtWXNMZmNHYU1H?=
 =?utf-8?B?TzU5NCtMSmpibUR4OGI4N0Zob3lXbWhVc0E3OXhiQWhhVjVNa2laRFZ4OWxr?=
 =?utf-8?B?YlpvN3ROVVdXTys3dUJjVkxOUUExVXd5SHpGZkNBdG5FMGVzYXlmY3VHQzlp?=
 =?utf-8?B?Q2RrYTJSRzAzaVgxK2tCejJ2SWpYY3JYYUo0N0VZcXRjSDFGTnZEYmozTklG?=
 =?utf-8?B?dlhDZ2VzYWk5UWJsRVZiNXVoeDZEZkJ0MlhzeVBIS2tqZEJtenRBUUhqcjRD?=
 =?utf-8?B?cjladHJFTjlhcExXSTdvR21iUWMxdEF6YkJsNzdlcjdGdE5GOENyemRmaHdu?=
 =?utf-8?B?YzV2MnFMQkxKUGtIYnhYa0ZVK212V3ZRTUpBaEVZaTg0R3BOR2NJaWIrSlBY?=
 =?utf-8?B?QWRseDA1RVI5NHQwRVZtYm1FYlhxY1ZXMmErcW9OaVROcEYyZWM3U3JzbEVk?=
 =?utf-8?B?MytQQm5xNmJtZW5leEIxSkZBbFFzZ1JhbjdwVkFvNEZ4ZkdUMHY0SGx4UEhT?=
 =?utf-8?B?cGhrcXpZUGJkd1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f58e65a-05f4-4b7b-9a54-08dad227141f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 16:30:51.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQrdK6QOtTHNGuLUsJhpW5SYe0c7R9DdEH7lhbo88mrLXY9Ju5IMXMhI3SlMJ+cgJdy4FKO+Qj6+DBZbqdP+kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_10,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290091
X-Proofpoint-ORIG-GUID: RJ4sCiLhI4s1FdnEZBViyNrRsB_IRRbY
X-Proofpoint-GUID: RJ4sCiLhI4s1FdnEZBViyNrRsB_IRRbY
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/11/2022 20:46, Alexei Starovoitov wrote:
> On 11/22/22 7:18 PM, John Fastabend wrote:
>> Alexei Starovoitov wrote:
>>> On 11/21/22 5:48 PM, John Fastabend wrote:
>>>> Yonghong Song wrote:
>>>>>
>>>>>
>>>>> On 11/20/22 6:10 PM, John Fastabend wrote:
>>>>>> Yonghong Song wrote:
>>>>>>> Currenty, a non-tracing bpf program typically has a single 'context' argument
>>>>>>> with predefined uapi struct type. Following these uapi struct, user is able
>>>>>>> to access other fields defined in uapi header. Inside the kernel, the
>>>>>>> user-seen 'context' argument is replaced with 'kernel context' (or 'kctx'
>>>>>>> in short) which can access more information than what uapi header provides.
>>>>>>> To access other info not in uapi header, people typically do two things:
>>>>>>>      (1). extend uapi to access more fields rooted from 'context'.
>>>>>>>      (2). use bpf_probe_read_kernl() helper to read particular field based on
>>>>>>>        kctx.
>>>>
>>>> [...]
>>>>
>>>>>>    From myside this allows us to pull in the dev info and from that get
>>>>>> netns so fixes a gap we had to split into a kprobe + xdp.
>>>>>>
>>>>>> If we can get a pointer to the recv queue then with a few reads we
>>>>>> get the hash, vlan, etc. (see timestapm thread)
>>>>>
>>>>> Thanks, John. Glad to see it is useful.
>>>>>
>>>>>>
>>>>>> And then last bit is if we can get a ptr to the net ns list, plus
>>>>>
>>>>> Unfortunately, currently vmlinux btf does not have non-percpu global
>>>>> variables, so net_namespace_list is not available to bpf programs.
>>>>> But I think we could do the following with a little bit user space
>>>>> initial involvement as a workaround.
>>>>
>>>> What would you think of another kfunc, bpf_get_global_var() to fetch
>>>> the global reference and cast it with a type? I think even if you
>>>> had it in BTF you would still need some sort of helper otherwise
>>>> how would you know what scope of the var should be and get it
>>>> correct in type checker as a TRUSTED arg? I think for my use case
>>>> UNTRUSTED is find, seeing we do it with probe_reads already, but
>>>> getting a TRUSTED arg seems nicer given it can be known correct
>>>> from kernel side.
>>>>
>>>> I was thinking something like,
>>>>
>>>>     struct net *head = bpf_get_global_var(net_namespace_list,
>>>>                 bpf_core_type_id_kernel(struct *net));
>>>
>>> We cannot do this as ptr_trusted, since it's an unknown cast.
>>
>> I think you _could_ do it if the kfunc new to check the case type
>> and knew that net_namespace_list should return that specific global.
>> The verifier would special code that var and type.
> 
> Hard code it in the verifier just for one or two variables? Ouch.
> Let's see whether all export_symbol_gpl can work.
> 
>>> The verifier cannot trust bpf prog to do the right thing.
>>> But we can enable this buy adding export_symbol_gpl global vars to BTF.
>>> Then they will be trusted and their types correct.
>>> Pretty much like per-cpu variables.
>>>
>>
>> Yep this is the more generic way and sounds better to me. Anyone
>> working on adding the global var to BTF now?
> 
> Alan Maguire looked at it. cc-ing.
> 

Yep, latest version of Stephen's series is at [1].

As mentioned in [2], I think we want to figure out the right
way to handle tristate support for BTF data. That discussion
suggests some folks would like fully module-delivered vmlinux
BTF, so I think we need to update the naming slightly in that
series to accommodate where all vmlinux BTF is delivered via
module, rather than just a subset. If there's any other
feedback on the var series from your perspective it'd be
great to get it soon so we can roll it into the next version.
Thanks!

[1] https://lore.kernel.org/bpf/20221104231103.752040-1-stephen.s.brennan@oracle.com/
[2] https://lore.kernel.org/bpf/43fd3775-e796-6802-17f0-5c9fdbf368f5@oracle.com/
