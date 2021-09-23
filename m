Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7D14163A6
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhIWQxx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 12:53:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35396 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233891AbhIWQxx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Sep 2021 12:53:53 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NFfR6L021389;
        Thu, 23 Sep 2021 09:52:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ysT4cUkRJgf2UV1h2Qoo7BDAKw2zxzSauQZJrPn2okE=;
 b=SUHGivYWZ6ZCjcfdwX2WMLMQObLC2Jh6OZM7+epw/9+IZm0/srceJu1fxlC3g8TAtI2a
 PCuBPQVDwkTFBYcvvSAsKhM18YjGLMHMAiUj60zNqGQs+5e0/06b7fCJ1wFH0ycPAVRA
 wlZPIOvVDc2hDNxMZdU8p3XAwGdcHwEJdY8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b8ggjvv6e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Sep 2021 09:52:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 23 Sep 2021 09:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKmkpweVHZg6EvU7DbpYMtHG4MZlT4z32dGju2xuFNpyVl6kHSkFUG6auzcf8YgLTov9PvXuhvOQMTklzaSPGUkTeLlH/NRc2bTKpiMfRjRc9Vi3+FNncT6c5PeBlanvSNdJ5K0UvTA7BoiOQEbtzl8avBnA2ZZlYs0YGznw9pBqxDDV10/ay0fwU13UNSw9+uGQFm7cDmatpvHKd7W3jnLlx9tkQCX+VP+U8LaKUSphV0AMA7s3km97899JqzwHd5Yzv+08drNR2psMYmW+Ea83VUbpO0LluHfFkd0Y06jVP/IHQ62wNlIRaIxTRv/q+R0JJdtaYP46Vb+aN6Ybkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ysT4cUkRJgf2UV1h2Qoo7BDAKw2zxzSauQZJrPn2okE=;
 b=Cvi9zkn2gU8Zrm2f4CIVGAV+YRe0815RaEzqXCtmThxs3andkK1zsvQARSOnUVuvyVEnY38RfmeR4yzCQL2h6uoIJ/dMhuXESrph9m0KKNIcqZDZzhvRJnBfaXPE3VTxRcpNKXANuWq02sRsgw2gzSxrl6fPuc1jK1QMofAKMJDv1c2VsmeycAZRzeiUpU+G0AdBfoJzVoxejGZm4hq+3PKs5UL0jQW6C/ohA74g0cLrSqoehKhEHKxbzwqW1qXxoACSAnDe3Cqh0kVdMYvETBWuU0PyEfTLta2YbPMNe6VsDVOdHi7quh8t8eM8QCoDbH7DeshsMa6ZM8F7pDiGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1435.namprd15.prod.outlook.com (2603:10b6:3:d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Thu, 23 Sep
 2021 16:52:05 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 16:52:05 +0000
Message-ID: <614d41e9-647c-4cb1-4bb1-607f0cf099de@fb.com>
Date:   Thu, 23 Sep 2021 12:52:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 bpf-next 2/9] selftests/bpf: normalize
 SEC("classifier") usage
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210922234113.1965663-1-andrii@kernel.org>
 <20210922234113.1965663-3-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210922234113.1965663-3-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:c0::23) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [172.16.2.93] (67.250.161.190) by MN2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:c0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend Transport; Thu, 23 Sep 2021 16:52:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8ceb1ab-5f77-4c02-5c97-08d97eb27958
X-MS-TrafficTypeDiagnostic: DM5PR15MB1435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR15MB1435297E34DA287C2ED901A1A0A39@DM5PR15MB1435.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TEHvgTEuF1syDqnhsHpcukoVY8QqMCMFB3nopuHdAcAHOTbI0uIKGbugRXjfi4wybJRdWF71tcoeyX0GefoT7jzMqXOSg0wl6k/Z/H/op2DgdclFbuHq+MyXhSsNOninngQHxKnS6YBzip3D3k+kdZRc0vXkVlfXoESVU/p/KthM2y0E2a9//DEAmjBuecaDlvnITFHtDVVu3ABzgi4FCVpgqsF1h5+/Bz5b0ZpCcuu0HJlMqoI+5oj8tjTSVz/M1cxNtIM0FK1QtS+dZ+5WITpVurAG+R0XfY81svjhAv3zGaPvMrMx9Hazkwr8qDO9vexbrJ0oksewDKn9NM0SrVpIerogOF+GhhNcOefEfGHohE1gyDy/jRFQEvPbdEe52iPkmzwun0DHK9Zu6h2a5boZuZDuAQDB6LtvrjvEwLpwkbnFXjTHm8o8doi1c0JSmd32GTg6uCJ+fYPVCF8Yj26Kvfs6qNapYclN9KeDx7eMVXD51O8Lu7Ua+hBS7JKc/dwbcKHY1KKlm44nIOJDXVvLESPgDih8/62+c1MKJCSWZ0qAt3Dn0hMPo5yhM8d8scM1gYYpkZEqpzCEOj8Ryvrlaf0dV53G5kZUZxhsqzW/MuwZqsjrZwmhC5V3jNazm5AdjJD15MFeUCtWryGdmzU561RYt0viIXRkpi8Zhmd3w5N5K9HLmdNXgHBRVWYcNpd1fgnsLxgfkybqWoYK1QZefUk5Xv9uOkBiV9bgX28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(31696002)(2906002)(38100700002)(31686004)(5660300002)(66946007)(2616005)(8676002)(956004)(508600001)(53546011)(66476007)(83380400001)(66556008)(316002)(26005)(8936002)(16576012)(4326008)(6486002)(86362001)(186003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEFSbE90WmM4WjhKZ2tXWjJVdVN4aSt0TjdUQWZ0MHZJTkFpbDJVcTJvdzgz?=
 =?utf-8?B?ZnU1eDB6MnFlNVEwU2dDYy8xVUtUL2prMmxPdGU0cVZCNUxPeXI5MVR3eHZP?=
 =?utf-8?B?YnloT1lWUHg5VVVzcFFqYWdueWVPaGQvVExKL0RPSGhBTlF2a2o5cUphbHd3?=
 =?utf-8?B?NnI0WmE3Y3g0L005dTFCMGVxTkxIZVhrS1A3MnBXa20wc1ZwTDRqeXFEeUFO?=
 =?utf-8?B?dlRiZjFsTHZyM0pGaE9FOTV3cjdvTTBBNW9FNmloaTRvSThiOUxKblBES2VR?=
 =?utf-8?B?T1hrOUhEWllZaFNSUGZZMUt0djRvMGlNWEZkTkNDQmVERjdiY3p4cTFFRkpD?=
 =?utf-8?B?bUhrZDFwb1dWdVpaT2hkbnRMRngrYWxpYlM2STlzcEg0Z3FYMUdCSXYzRDhV?=
 =?utf-8?B?Tk95d1l6N2oraVlrRElDWkEyZi9XWVpCQ3Z6Y2xGdFBTYWtNY0ZmRUxOTFRV?=
 =?utf-8?B?eW4vc0oyUFpjckpTUWYwUUdvdThBOVl1R09vdnloREh4ZWpSYnFWeitMcnBJ?=
 =?utf-8?B?d1hHK0RoSWlPUGZsNHlZOU4yVW9vUHBrZDFobUcxZkUwMnlDNVR5OFF4Vjgv?=
 =?utf-8?B?cEVsaGJ0RGpRQmY3cm44dFNsbnluT2ZqUTRlT0hJUzIrNDBxRXlxNm1SQmVk?=
 =?utf-8?B?Y1B2d3krb3Y2YTluUnhrTURadDFqcWV3dzlOQmdma2JaYVlVVE1pTmRZRGpt?=
 =?utf-8?B?V0x6bUlrdWRlaG1Mejd5aGZ4cDZJU09acXZKSHR6OGowQ2dJbTFOR0Y3S3Iz?=
 =?utf-8?B?b2lUTFR4ZWFKK0Jhc0p6bHdKbE14SDB0Zk5ZcXYxUnphTi9Ob3gxSi9lTmdZ?=
 =?utf-8?B?Z3RBT1M4YWswMDhIaHlXQmtzN0Y3cGFWbDdFdlhQeFZHbEN3anpYTXJhRXIz?=
 =?utf-8?B?dHN6Ry9Lck9HM1Fka2tJek1XQlM3R2xjQUJLbDc2MURaLzB3Ujl4aW9lVXNs?=
 =?utf-8?B?VTFoQlVYdXJwa1A5R0ViN2VTQjdKTGdEdHFqN3A5UFpwWGxHalY5ME03RVlP?=
 =?utf-8?B?MmVCRkJjRlpua0ZLK29zWWlOeHRCcFZ3RDdxMlJXdHFjd2FSVCtvc2p5c2ll?=
 =?utf-8?B?K2RtQXk0U3F1MXhjZzQ4Rm42R0EvanBkYlVTV0Qxa1U4UWZLSkJqSUxzMkF6?=
 =?utf-8?B?N0FTM1ZmZzNzSHQ4cGlmQ2NpVGNqaXRoM2EvT0xqdnU4VHdFai8ydEs5WHRP?=
 =?utf-8?B?Ri9hYVpaenUycTVldzNLSmlCSmROZDJaWXh0SnkvWXVjSWNITWs0cWpqZHdn?=
 =?utf-8?B?emtXMDVuMmVHTU0zZnlEbS9DZ0d5cm9NWkJtSXdLN215emFLeG9pRUdQVW5N?=
 =?utf-8?B?Z0xZVVpFOVBXajYyWkM0cmNSRnR5eUhIWjdlU2lTcGhHOFdrRjBjLzVxc1Rp?=
 =?utf-8?B?VlNSM2NIMUdTaytWTXFwakVFN3RGcURLSU1pQ2ZETWtZVUZYZGJrMXd5ekYv?=
 =?utf-8?B?WFQ3L1IyNEd3M3lJa2NoKy9ZckszRjFmRi9udzBHSGM0eWU4ZVhCTkZJejlB?=
 =?utf-8?B?UzhxMG9qa2YwUXliZ1ZrQzg3YVIyWS95T3dYSUZCb1g4WHJaU211aFgyUjhJ?=
 =?utf-8?B?RlpRTUlxOWVyK0lSM0YyY2pHMStFc1FVN1pSWTkrZVZWVzIvTGdhaWNWazdZ?=
 =?utf-8?B?ZUR1VjVYY0ZFSzRBVi9oQkV2MTlGdzlwc1hMdmd3Zm02MFZ1WHBNVU1qRXla?=
 =?utf-8?B?VE1iQWtSWWtmUmxzdjM2SnRXYzJVTEZ0Nlk5Mi9DeVYwbDVDb0RDdEVHTGln?=
 =?utf-8?Q?cwlg6ACXevsw+uvxp+pG6ThWL5tQJnpObshrFY8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ceb1ab-5f77-4c02-5c97-08d97eb27958
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 16:52:05.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQgbf05guy4m0WLXJ24HWmLhGqVjPNuKJpOgOxEYox3jQilQxfYWwbK2+OowqMya7LckbS8gQl5mj/xnnHU5IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1435
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: heDqYPXahBlJbkPomt9IolBCDqF6LtHR
X-Proofpoint-ORIG-GUID: heDqYPXahBlJbkPomt9IolBCDqF6LtHR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_05,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109200000 definitions=main-2109230103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/22/21 7:41 PM, Andrii Nakryiko wrote:   
> Convert all SEC("classifier*") uses to strict SEC("classifier") with no
> extra characters. In reference_tracking selftests also drop the usage of
> broken bpf_program__load(). Along the way switch from ambiguous searching by
> program title (section name) to non-ambiguous searching by name in some
> selftests, getting closer to completely removing
> bpf_object__find_program_by_title().
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
