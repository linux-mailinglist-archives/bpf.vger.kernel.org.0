Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88892EF65F
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 18:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbhAHRTf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jan 2021 12:19:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8604 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbhAHRTf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Jan 2021 12:19:35 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108GqW6x008164;
        Fri, 8 Jan 2021 09:18:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=H4oliN7CKkX2REamPvkk/6qHKJIver9wub8ZxejoKeI=;
 b=ePQ43ytNt21jfkhp1Hs2Pvg7Ten61PKMT/TVBgV+MmOn43quSVTbF1tL0TxP99r5aYIF
 SLyM2zHVEbfn7hFcn8OC+rXt8ul8wKcSNd5Ass2L3Esab9yLnbdeL8rksxGEbruNwtU7
 QB18irQK87JbHqV2E1iYS5fbyD4jo8WcKKU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35wpuv9e07-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 08 Jan 2021 09:18:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 8 Jan 2021 09:18:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tt21n6b3dfJY3oTn5+eg+9xpSNC0i3UzE7NvKVjZd4WyCblkTK5rnxBD9vnEqj0wTDh1Jn8Tn1OWyGjwPpUt1AhlJo+FATVeOKLFArSzkixmosenufivlInmg9Qw4OHeEMRkL0KE6CVKfC38PqjbK9oHkSRF0Gj1QL3uaPHqYSaMIy6VloR93gFXZd1uLN0ucy03N/A4DbBIAJWrAxXGIH3uU5kE5ixsM8CgoE473x7P1doquJxcDSts7u5/oHVmc2oiQPy3HJmSIoNJUvMXiZFhr2KEDb9+jgyk1ong+D8s5dxMZi0adFIxa4ea65KaMuXcUwjuE9WWOwamdWQ97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4oliN7CKkX2REamPvkk/6qHKJIver9wub8ZxejoKeI=;
 b=iZIzioUQDb6+OVPrgJZR9qy9nREoOoDs2hpkMvHuhgtUNpIy/HobH+30u0MuPBpG4jElobDlA6pGQdmjY/MlmvkeA9QchnX03f9jIQmM4rm4ynKm5Q2nwTuJXKUm1Qqjub6Dd+M5aWJOQorLgLwVC3oyukuWb2JUwb3+sws/cNSFN+8xw5KKFcFHmw4Vl3IXyGF2l1TWWrF/MgwDNdQV5uqymX2WvcHbn/tWiqoAYO4X2rjS9Wxz9wWgcSnlhXElITsAtkVKTETO63HzTPVn5kZ96etVf1l3V4Qelr/ZmbbaxAdppeiUy2xIQ0SbiAm7ABnVpl9MMlA1qbbEYdtuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4oliN7CKkX2REamPvkk/6qHKJIver9wub8ZxejoKeI=;
 b=VOrOfII1IfH10C5CtO35tZaNo3xz7un0/jMe7f23SjC+0slENeNqFak/E72/PNmpGge273CVfVXCooNXelpF5RW+TRJDjn2kbGOkKVDwM1deWrubtsH7a2Kqyevvf9Zexb680vJsdG9Wy3lMijaod46kEhbogczPZpXzJz44NRE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3415.namprd15.prod.outlook.com (2603:10b6:a03:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 17:18:45 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 17:18:45 +0000
Subject: Re: [PATCH] tools/bpf: Remove unnecessary parameter in
 bpf_object__probe_loading
To:     =?UTF-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HKAPR02MB42916F8599BF7B58AD73C27AE0AE0@HKAPR02MB4291.apcprd02.prod.outlook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f19a1163-fe4f-5a5c-3d50-3f035a080359@fb.com>
Date:   Fri, 8 Jan 2021 09:18:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
In-Reply-To: <HKAPR02MB42916F8599BF7B58AD73C27AE0AE0@HKAPR02MB4291.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:2644]
X-ClientProxiedBy: MWHPR22CA0065.namprd22.prod.outlook.com
 (2603:10b6:300:12a::27) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1627] (2620:10d:c090:400::5:2644) by MWHPR22CA0065.namprd22.prod.outlook.com (2603:10b6:300:12a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 17:18:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3952ae6-5ecb-4968-e1bf-08d8b3f9747b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3415:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3415D856B780C6976FC36428D3AE0@BYAPR15MB3415.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UewTYN/yN+NsGDuUUP3cGvq5WXN+NxTWvWWbKKZzGYjR2xl2zZfJdH+M45bvRmoicwLrCZ5ZlPXBJk2dRtNupUO71ml2NOmTvPERrCCzqeYnbpitdsozyZSGVFRyU18bMMAAxzOLvwkakhz8vFqCA8PoavittP0mfCHAJEoFL3IYKmG/iSg1zb1zdOnnN6KpNvJK4/KDaQBZd3WEnXYz45iDynly4YsHPkzKb611WtMcmz1kZVWMbO4SP5GjnBs8uXnrGwzLs4DkypWghe/OPkkhWJZpl/9h7nibp6PWWc6k93+v6uw8ojo04l+qiXyHFw3GtM89cnd9Hr+VTZ4AooJezTL2WVw5JzdrScaif4FFLjyu/hpug+NLPHIWmETw12fRjRu8bmsTvxF2PBiCDkejBBB63bb7Q9yQSROwSfnn70iRKywfh8dKWvz8v088mR+HTPHlcJ6iuWC2BZHqfG3Mc75ZuFx3AwO1+DBCm/m525v63Jc6lP+SfGSemk2HNFhxO28eIZXpIo8gVHfdOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(346002)(39860400002)(31686004)(8676002)(16526019)(86362001)(31696002)(4326008)(2616005)(558084003)(186003)(6486002)(8936002)(52116002)(316002)(36756003)(478600001)(110136005)(54906003)(2906002)(66556008)(5660300002)(53546011)(66476007)(66946007)(101420200001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TUNodUdOazZZS3h0ajVYcklhR1lXV0pxNDlLV2xjbHpaR2RudnV5NEcyVVhR?=
 =?utf-8?B?L0JmTjB5aWVXbWxkWDFOaU5WaTdxU2QxQTdETUtyWjZMUXB1VTBHWG51OUlF?=
 =?utf-8?B?NWlQeFh6S0FTL24wZy9pcDUvcW9yYXA5N2IvczIzS1RVMXAwR2hSZU1KOXRE?=
 =?utf-8?B?ZDRFSFh6U2oyWGdlWCtyZWE1dFBDUnRXelh1UHFCQmJnZ3pBS0ppYWNYa3VJ?=
 =?utf-8?B?Zm9WYmhmT09WOHNCdlo0VGMzQmVvOFlBL1J4bWt6TGtlUDFEU0lLeEtIUXlk?=
 =?utf-8?B?bHo2L01mMk9aMEc1K0NlN3ptcnpWY3p6NS9wMlVHOUN0bDdHMmFWQ1l4SXJm?=
 =?utf-8?B?VHppdWV2MlVuZnpCZkE0NnRmc0xSb0I2bjI2ZWxPeDJEUTlDUXo4dExkMDls?=
 =?utf-8?B?ZHFSd0lSWG5RWTJQazVrbzV0ZXlOalFTZEJOdGNhRGh1U2E0YmdBbjVlTUFR?=
 =?utf-8?B?RTJmTUMycVpOWTRTUFZGYTZuMy84RklGUUFWUGprQTR0Q0Y2em5URXNhRm11?=
 =?utf-8?B?UG1pb0RVcFlzcFRPUnd6RSt4ckxVVFNTalpWNWZUMUFnOWNYdnBHQnhpVnFk?=
 =?utf-8?B?cGRZUG1JL1NsUVpHUnYwMGdXaGd0cmM4NDduWXhyeHF2a0FYVkxNU296cGJQ?=
 =?utf-8?B?SGQ0Rm5iOFQ0aUtuaWpoVkdpZHkvUU9NS0kvUmNtWXJJem4wSGwzQ3ROVnhy?=
 =?utf-8?B?V2xEOG5JQzRra2VjUTM4SHJzT0F4QzdXYmxidjJlRnZBWU5KS1dtNVUvMXNS?=
 =?utf-8?B?OEdUSDFHcWpKZ0VVYTJjdTd1RVRUQ09wajlwbXkvWEQ4ZGhZMitOdmxzbmtB?=
 =?utf-8?B?SGdhRW5ZVUVWOFlWM0lVY2VPZ0FrR2huM3kyQ1VxYXV1VWNKcFNRZjRha1Uv?=
 =?utf-8?B?Y0ZSOTVBYS9OcUhhMDI3THdpU1Bhemp2Yjhlekt5d2piYzIyQ0RHdXBpdVFk?=
 =?utf-8?B?T1hEMEZGeURiUE9DVVBKQnhKRE9SdGpRM2pCbkpuV3cwM2l4ckFLSHlpSmQw?=
 =?utf-8?B?dTZIc2M4UElDTG5wL1ByczhLTno2NkRrMWxINUJ1RUR5Rlh5YTJZS3gzbGU5?=
 =?utf-8?B?dzVMck9uQTNqV2tDZUlGOHFkQ3NncGpXQ2lZSHNLYlRQZWE2WTg1Y01RYmlD?=
 =?utf-8?B?em1qMDVZczZNWURpM0ZTQjl0ZzNyNSszWnNVdEpua2p6RGk0ZUpFMTIzRHFQ?=
 =?utf-8?B?T3VobTV4Z0RkZE1LeHdjR2czR2pDeFRxYlROcmZ3ZXZPN0hRbkJZZnFHZWVl?=
 =?utf-8?B?bDkyeW0rTE9hVmI4K2pITm1LSzRXeXNnR2xyYXViTE01MDBnS3lrbnVEdkRl?=
 =?utf-8?B?dmxVOG9jczd0Q3hCMVY5VENoTzM5M0lGWS9wTC9pcG5oVnU2QzUxYkw1N01l?=
 =?utf-8?B?TC8wdVloMnNoSXc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 17:18:45.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: f3952ae6-5ecb-4968-e1bf-08d8b3f9747b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8anQU4u/IRDPb4grFkLNMEX2XiTnqz0AsuN01hfeE5bW4HMxGULUwmybj2AioQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3415
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_08:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080095
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/7/21 6:08 PM, 彭浩(Richard) wrote:
> struct bpf_object *obj is not used in bpf_object__probe_loading, so we
> can remove it.
> 
> Signed-off-by: Peng Hao <richard.peng@oppo.com>

Acked-by: Yonghong Song <yhs@fb.com>
