Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F974B28F9
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 16:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351330AbiBKPRc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 10:17:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiBKPRb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 10:17:31 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA1B0A
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 07:17:29 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21BFDS0e004608;
        Fri, 11 Feb 2022 07:17:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=NVk3RX+26IKkHJAf5VWfVBPmqUC50iFsxl54SA01B/g=;
 b=PBSRe8JfCE/P4e70STNRkbmxBn7FirxbC/Kt+iX1RXqkBCbYrtsvK9IJQrb6aCvWuq59
 Rvw8TRbJ0AP/fMz74NgLxRa2uHlMjC/TfD0vGt7qK+87qgot17aLTXASucWPTANmAvf1
 g+lyB6DuJFXuf0yip8u2omsx7IniuswI7kw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3e58p9e199-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 07:17:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 07:17:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms+YVNDCMbYpubsG8dMMYbDjhV0wxvMmpAEpKkGTa5i3dK+h6e1o1Qcmu+pRaSN7EeTwwkUo5ifpToUTDIpnHewRyPoDOMJJ9h51XNJvEAlofs2MBXJJinyx8pTrwHe4IYX6HEpKT7G3MAO4lhoL2Kkgr8u2e2Ys+6MrrP0AMGSh/MgnV7IafxpiP9MwurNOkQOfXwrlvcGhr65JR5tVggOMZGmxK00Yb1pH1/HZ5VcWwztSKuary6BWoikHvLl6TMyPSsSrkgUyl1KHH8sNGBFPHOKBitUof4qP1XLlACE0vJ9x3M4R2RQRXzI4OtUq+15q8gAmXh/qbox4Ia+rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVk3RX+26IKkHJAf5VWfVBPmqUC50iFsxl54SA01B/g=;
 b=a1MGqw2fdKkU/wUtI0eEfrtmZ+jPxRL8SCjlzLg2ws3gQaPOb9JdXK7dqmWtsFXo+56/IMMftG4Iu/Hwlwv9PlEeqC5UMadTnurxNUCsa1qyNTjCOUj4aQogtQ1XjX9g37nHF5+OWkhZTYL5YhiEDaf8xBcytwXaOAmDKy+c/cha7Th84knn0Mz1EKQUMGGM1ysv3Jwwgg4BWN0+bjlNPlVNtEIIxQWWpz7BwwmjvBBOMvF5bJ4ks6DbKDBmYV8GRE3e+zWu8uaHnEuYISC6EbWLIdF40XFtnhK0dGGeeQaFb/GzpPlJ4J83kvmM4dDY5+pTpPnWtQebxhzQVYF4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by MWHPR15MB1870.namprd15.prod.outlook.com (2603:10b6:301:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 15:17:13 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b%6]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 15:17:13 +0000
Message-ID: <ebec347c-4b81-0f00-0294-b56bf8f33195@fb.com>
Date:   Fri, 11 Feb 2022 07:17:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf 2/2] bpf: emit bpf_timer in vmlinux BTF
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20220211073903.3455193-1-yhs@fb.com>
 <20220211073913.3455777-1-yhs@fb.com>
 <0d21a6bb-c8d0-840c-faba-365e0fc298e8@iogearbox.net>
 <4fdfe586-859c-63db-dbc0-63b1ced98aa8@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <4fdfe586-859c-63db-dbc0-63b1ced98aa8@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:300:ee::17) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deaa474a-c55c-491b-bc82-08d9ed71946f
X-MS-TrafficTypeDiagnostic: MWHPR15MB1870:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB1870784749E1344D056AE9F6D3309@MWHPR15MB1870.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJjAHSXcBx9v2/z6wcJR7PslNU5zXWWTTjbavqnl4SjfFo6tbmHO+tPZAlDSdnW9KbZNkpkMQvH0Fl51ecpGs+nSHu8FDMs5Tw8set9fqqDkGYFaZtZQHPMG68s3maHP7AT1js2iRBok4cHKmJ+wtQ4GT39gVKzikpSv5w/9lDY7T/Rm2hyanKS/XS8wtM9twWolaKW73LufOjd6NEWCrnB9vObL33GAHExA087un4mUE7QkSdC0j3YIdHrPKfMLIKz/L5BDnGRgk2f9PD0sLRUWsFjmrlUdmLh4DRCDHIp1gJhr6HL+CTSAZV35dIDXRrgXkuVjEjwEm1mLdYmwpBTKLvf8/QiBsFigWh9YyObA1qQ2VepB+0TYWheZ/rZHCt7BGk/qOkdlIuTxTjnv/k9Td+Y9g4rAl5jnXC1Squzum+VFuAOSN2Z0LL7lR8ETZbZdHbxLjEUftQ4jaCCO29Yo+aH+QPqARDouhNeiOUx7vvgWQfca/WRNUP/Q+9VG3PE3KZXCvj4Lpgz8J4YGFjLo83nQ4xAO24XzRnE+SBZBJZVjkMK0HzpZlSFUdxUYvhA15yiymFhGyr3EsWaE4xTbjEqhRHHqw3tmeuq0PwEwuoriVMcFtoGIqSx3LpfC1dwzoy0XtRz9NsNMxbKn5ZM4s1O9g7GM6bocsGdS8CPrjrVxqPSeXMa92I5JyIOJ1+esYWRsQn6TbGniUQHAPFkwT7qHF7UXJDhT3BCJtYtzHkhmqHFyIFPfJfxiRWxEIP2UGDx/8n3Ew2NtuH4WASVlq4+Lxe1Mg+lCov+QAcOhWyTb0y53w1MxNYFGbxEF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(966005)(8936002)(6486002)(31686004)(4744005)(83380400001)(36756003)(508600001)(2906002)(4326008)(66946007)(31696002)(66556008)(38100700002)(6512007)(86362001)(66476007)(186003)(54906003)(2616005)(6506007)(316002)(52116002)(53546011)(6666004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEJxMkpoa09XSC9FQ2dTS3Y1SGRCT2IvbTlkUWFIV3l0VDlncVRzZlBnbkcr?=
 =?utf-8?B?TU9TZ1RiU1MvTWIydU1TLzRZZmNUZ0xscFhQOUliYWxVVWwrdENxald4TEdo?=
 =?utf-8?B?RzNwOVBYWlRyaXd2WThaelpOcnRONWI1cDlNRDN1b2dyRlF1TTN2c0RFSTJj?=
 =?utf-8?B?VWxYYXd2ekNObHBRTVc2NEFSNXYyMERiMlFtQ3V2ZFBQb0NScFdiWjF4dU5Y?=
 =?utf-8?B?Mnp6MGNranIwNU5TNWo5MlNSak5yaXdmdHpjNDBJVGJoNlhUeU1vbTF6TlBF?=
 =?utf-8?B?M1M3UGdIcENSdlQ1VUh4UEVrT2hobWNmblJ2Yzk2c1ZFMjZySXRhbTNzWXNh?=
 =?utf-8?B?eXlvU09INGk2VmhqbnlDSllXbGhvbWhTaGJkTzlVQXJpOHNaamF0ZTV1L1ZG?=
 =?utf-8?B?enRqVWlqLzBCbWhjQkFaZ0lteXdqWmRMODN0cWxmbzl6Qk9NLzZEemhjRlM2?=
 =?utf-8?B?ejRhZWdqTjNwdE9UaVRxdkYzWll2RlMxM0FoTjNua2JDQyt5ODAwVlN1eHIr?=
 =?utf-8?B?bjFsSEtEMG5MLzV3a1hTdXJZelpRLzdPWmI4WWRhMkd2TGVrUHVyaXMwc0Mw?=
 =?utf-8?B?WnhTdDV5ZWVVajdMSDZkQjlYcTdTSHBKMytRRHRQeHQ5TFpOR2tpTkdLQWhR?=
 =?utf-8?B?Vmhkc0dkYjlaVEQ0a25mNU5nTDMrY0xuQi93UHBGVm5sNG0wenNhejZpZkxW?=
 =?utf-8?B?anRuQWNvNTZyK0xJRGI3V0NSUU13OU1CSStibUlZQkMvUWJNZHRBVlVMa3lL?=
 =?utf-8?B?aU9LaDc5TE1HMlMvMGR3WW5wTE5xZ0RDT2V6aDcvZ1p0SDVNSnpLS3p4VXk3?=
 =?utf-8?B?OENlMzE0YmpqQTkvUUNPbWRSOTNiM1lvS3dTVC92Y1N3cS96ejFlZmNPb2Yv?=
 =?utf-8?B?MmNQd2ZjMWhicjVtQ2c3c2dUTWZTRldDN1h0MUREd0xDTCt0ZzZ4aXY2U1Vl?=
 =?utf-8?B?S1E2SDdQVngzMUtVeTFGWkVJN0lEaUpzSGhjVWc5Vi91aFZiRGVBMmFINTFq?=
 =?utf-8?B?SEcxM3U1clFUVi96b1BOSEN6dUtOeUZUcTZPd2xXcVR2WnY4K1ZxY05qNW11?=
 =?utf-8?B?bmZCeVo1cUdLTDZXNXFSTi9YUDFIbFlsTVRNenlUUlArR2docno2NDBERWJ4?=
 =?utf-8?B?a2p3OSszTVhKQXpZbkNPTzNZSDRHdmx2NTZMYmtFbytTME1Yb3ZHUE5RTWZE?=
 =?utf-8?B?cFBvT2t2UWVCYm1CeGhyY2FEZi9jODZuUG1YZFd4cEdzWVhmYUs2WEdPeGxL?=
 =?utf-8?B?M2RHTjU1NlVuWDIxV2hNRlJ6bjRoRzlCYXlFTDM3aUxNaHdxK202MmJWd0RF?=
 =?utf-8?B?UjJxYmw5RFp3Y0w4VDB0VCt3S1luVEh1b0o2Rzl5cjIrckJ6RytTaVkzRSs0?=
 =?utf-8?B?ZkdwSVpvMVQxMVRobFMybWQxaTdSRktXK3dRZG1zaUV6S3ZHelgzQnV6Rys4?=
 =?utf-8?B?VGxRa3NML3FoMmRobnA5T0Q3NGdHTUIwWE9ZeWl4cnZ5UEFSY0xYR1NEWFl0?=
 =?utf-8?B?V2RkZmZ3WllKK09GbVEvZkxUVFoySUZ2bEV1UFpIdUp4ckNWdmFjempzZGto?=
 =?utf-8?B?dnpaeTZNcG5ZbzBnQ2lTbm84ZDY2QlJkSEhyby9XU0dHVXRQOE5zZVd4UlV6?=
 =?utf-8?B?NHg3Nm9GQy8xNWI0VGE4L29pSEIzcFFtaXA1bUt0UWxKeTVxSUZNK2s3eFdE?=
 =?utf-8?B?Kys2d1JtWTc5UG1aeS9ZQk5uVGsvaXFXbTZ6ODFpUko0WXVvd3djT2tEV2Ex?=
 =?utf-8?B?R011TEtPMm1EZ1Z4a3lsQ0ovVFJYT2RsblppazVFSkRNZjgrVWhPVklwaUZD?=
 =?utf-8?B?YWN4cFdmUUNnZkEvNEMyZUxzQUUrYkVsd0lYbHJ1YU9rbjIxZ3NoUWtPWFgr?=
 =?utf-8?B?NW5kZDJMOHFCZHVacGQxVURCWUhQYlE3bGxuMnF2RTlpV2RvSFlMdzVob2hI?=
 =?utf-8?B?QU1EemhzM1VNTUptWFYxYmFzUjdaVVFJTDVxdVVqRHVuYzhrbHIwZ1RlWWov?=
 =?utf-8?B?YzE2Qnc2enNTWWRlK01HNURlWlNWdWJwOUEvbUFBcDd4bGxTQnVIMjRSS0c1?=
 =?utf-8?B?Y2xHMjJpR3hFa1VlN0NuTTI3bm15YVZUR2lLYVRqYUVhMDBWWnd0cDhWQjk3?=
 =?utf-8?Q?w6Gnx5VUT0TYWY70Bimr1WlVE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deaa474a-c55c-491b-bc82-08d9ed71946f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 15:17:13.0823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVLOwr5s/K99HTuufvNtyKQkZbNEgIVJ+pwXwMl9cXzSC4sl77DcvDG+Nrg/2crB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1870
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 7Cos4iqSgt20F5mULpnj5tbL2jWZ55d6
X-Proofpoint-ORIG-GUID: 7Cos4iqSgt20F5mULpnj5tbL2jWZ55d6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110084
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/11/22 6:52 AM, Daniel Borkmann wrote:
> On 2/11/22 3:48 PM, Daniel Borkmann wrote:
>> On 2/11/22 8:39 AM, Yonghong Song wrote:
>>> Previously, the following code in check_and_init_map_value()
>>>    *(struct bpf_timer *)(dst + map->timer_off) =
>>>        (struct bpf_timer){};
>>> can help generate bpf_timer definition in vmlinuxBTF.
>>> But previous patch replaced the above code with memset
>>> so bpf_timer definition disappears from vmlinuxBTF.
>>> Let us emit the type explicitly so bpf program can continue
>>> to use it from vmlinux.h.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>
>> Needs at minimum rebase for the bpf tree as target, see also:
>>
>>    https://github.com/kernel-patches/bpf/pull/2549
> 
> (Nevermind, noticed the dependency too late, sry for noise.)

Thanks! The patch is prepared based on bpf-next.
Just rebased locally and tested against bpf tree.
Will submit version 2 soon.

