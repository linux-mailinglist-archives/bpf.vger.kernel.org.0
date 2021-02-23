Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E84A3230E6
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 19:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhBWSmD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 13:42:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232180AbhBWSmC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 13:42:02 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11NIMW8Q027050;
        Tue, 23 Feb 2021 10:41:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hQaLXpwuLNkzFC47V3ijpspYXRH8mWbB3gNBdLkIJ6g=;
 b=fF590h4Ww+KuTVjeZBA2OPyBG878UAtk/2s4w3QUylM6wL3+v8Hj3fxHum3TpKfBWoz0
 ElIqY7kyY43fyHX5SJMptgc9fvC1+sd4I07rl1y0Lcqi1W//X+TebfP5PXLXH3KXPc1r
 oLc2aP//h5IxcIJ9cde1FpfWAM+2soSuxzY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36u0340185-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Feb 2021 10:41:08 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 10:41:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH46DPij9Ku0F9wwIXZGpRQAWViFtamngJdBmljnrWA/VOCOafTVQQO8vX77gCxLXFqlZGZzjYCGuikqW1h/h6FI9YrIjuitTNyzXH0FcVNJSKJBFrdyaRrHwj/fcPOjcQ3W524qEiPjLLTEaCm6jHgLYyMRT+m5gcGS5km+YV79P0N5XYMUfJzZPSETAllzGQBA2d1Lod8hlLNx5iqIFPZC876hV5Wf6g01ixE/LWubBmxK5Q5l1dnaEpKqOcyTHc4aGJYndNbdbPAyzJ+HWzak/5QimAVozXvAfvScz2g6E2HPesO13OxIBCRiSSrT57KKGmtPh+wvuIF9cuojyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQaLXpwuLNkzFC47V3ijpspYXRH8mWbB3gNBdLkIJ6g=;
 b=CDhZAxloA+JoKA8wUHQXngUN4YftE2xy7qLddXWCFqeNzECA166A0dzQcHO0efug2VA5GJN/ovlK36MlE0SdDqFeWYA7didejBSe+1Sd2NMruv1o94+CMGaxn4CXPnlIhiLFZ8qNdqlcuLIFPlzml9UJOJFpJ6btqGQLmaVyjepOY7B/vOvLKZizbvSyAQW+NXkEPN5JLlT3XPaEBkmSCScXELcCrSnMHpDpEN3/qniccGB2ESAANW5G6lCq6c+YKQp5p/8sbWG5XM3yXhlSAVheW6IsgnNzIwNdPfeyaiRyJAb+mhe1Fi9KtRE+9sPjw1gx9DkPkV+8KzYnx257KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2205.namprd15.prod.outlook.com (2603:10b6:805:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 18:41:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 18:41:05 +0000
Subject: Re: [PATCH bpf-next v2 05/11] bpf: add hashtab support for
 bpf_for_each_map_elem() helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
 <20210217181808.3190262-1-yhs@fb.com>
 <20210222225619.iakpkks7htobsdlk@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4b6acd8d-8299-5881-3240-3e06539bb678@fb.com>
Date:   Tue, 23 Feb 2021 10:41:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210222225619.iakpkks7htobsdlk@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:668b]
X-ClientProxiedBy: MWHPR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:301:2::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10c3] (2620:10d:c090:400::5:668b) by MWHPR12CA0047.namprd12.prod.outlook.com (2603:10b6:301:2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 18:41:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f4c1dc3-4b3c-445e-b896-08d8d82a93c8
X-MS-TrafficTypeDiagnostic: SN6PR15MB2205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB22057CCF8FDE8CC8A422DC72D3809@SN6PR15MB2205.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgzKpJakVPbaYub8EElokEHZ2gBtAbtDKZvRuX7rAsAiEXAd27IeomqP4u6M5spv1ZyuM/lGTKPY/1/Uum2xK4WLf9+46VQUwF5boXCyME9VgWpsJGBFSIBTT8aroiwmCS9612/XkTg8fe6uc4w/dAU8CVGrSvmm6lf/5fPehmJ+TLGctTu48JLlKn0I+zVjcfrc6NN6/vpScGWwKWEbOHZUtX/ot5rN05NU9rO31RnVPuXhJGP2xXvplpSs5HlQWVU3Mt4towbV7W66kDZDNaBCnmt9RkPHAD/EsCwie6hqOyaLtfUR/KgInTTA9bKKQQ8l92UjKtIC9PYjK+W9AAfeK3JS7EH1O25Dt7U9dt962UApqSOiinV5vpkYSWXkMmb+uwafccHyRfaAevmqJ8/j8Uw/SHySd3DRNx/e8+nU1wVuscRjij+uG2bhrlf/PFsY3RU7EjsvOT+sgfIFCbdvKK92HiAj73g8cETVurDmJ3f7NwdtmlakPwzYq0krJG6svqbygmwE7mCiSfMpeOmNjxq5qcOVF75pGv7cSosPNlRGDMJLNg4tgZ/MB5x5qnbWtkSnfVBQ7sDADm5RVS0qzYUFA95859MKqB0WVxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(136003)(346002)(396003)(54906003)(53546011)(4744005)(16526019)(6486002)(52116002)(5660300002)(66476007)(4326008)(478600001)(36756003)(186003)(31686004)(316002)(66946007)(31696002)(2616005)(6916009)(8936002)(86362001)(66556008)(83380400001)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VndNc0ZDWmRJRlpZRy93MVFzclRuNFUwdW4zcm5GSkFkMWpoOEtqN21tM2Rl?=
 =?utf-8?B?dDFoQ2krLzJpcmM5TDR1WVdZcDNMdHFydkZxbmNVK2d0M3BudGRFVnM0STVW?=
 =?utf-8?B?SE44UEphL2dta3JWVitmT3hDOHIrYlZPSmtFTHAwbzY5bm9XTFN5SnBPdzhz?=
 =?utf-8?B?UjlIbG02dHJIZDFCM1pHOFJXQUlCbzdXRXBaZVZuY25xMm95UGZNM1Fja2ph?=
 =?utf-8?B?TWNTWWNKa2lMU2RVQ1Q2MDZLM3ZleFRtbmhUV20rUGwvU1lKMWU1YUxQd0VV?=
 =?utf-8?B?V2xTUnJ4NzMvQXFVMDQ5TEsvYlBJL2FjRndUM2JVbHVDcG5tbUpTb0syZk1N?=
 =?utf-8?B?UEtOQ2NGaXR0ZnREYXBEMmF3ZnluYWlhR0pDRWJ2SXpYb0QzYWlpblNlOG1H?=
 =?utf-8?B?a21tbUo1eWp2VVEvS2tPLzNiTEU0OFFZTU5wUGNSYnl1b0xUbUwvNkFDUms5?=
 =?utf-8?B?c3JBQ2pyQjNrK1NoQmt5NjlFWmsyeW15b3VCaGRJYTRqclJyR1l1SUhrYTdv?=
 =?utf-8?B?Z0IwcERmMC9DR0lHazRydFA4THNRdVJQUWhRd3VSM21UbzJrdXAvT1JseWdv?=
 =?utf-8?B?K3hMeEJOSlJNWGZuYXRFaFRNSEZFY1RqZ2llSElGSFhQYXJuekMyVEFmaE93?=
 =?utf-8?B?cm00OGJZeXAzSzRiUDNRUGdoVnhoejJsTGFmWjR0Q28xeEhTZm1BTG4vd2JX?=
 =?utf-8?B?R3Q2SVFGTVJzV1JHNEsvaGQrNXhtaGcyVC9VUE84WkdralFZa3FIZC96S2wz?=
 =?utf-8?B?bVBLYytFbjNPK0daWnZnc0IwYjFLbnozeE9PUndFMVNJNlBrTndSNXZTWGVz?=
 =?utf-8?B?NThFUlROMmlNdWx6T2l4SnhLYkJNUUladmVOdjUrMFFMQ0grTHJkT3hqM3ZI?=
 =?utf-8?B?QlljdEtVcnpTU0NTN3FHcGNpR1R6V2hSQ3FySzZJUkhjY1ZoNVBMcGo1RHVV?=
 =?utf-8?B?L2hyU2V6ekhUSlNrRW9NbHNGdFdRaVpTK2hXU2N0UnkvSWN2T1ROUHdKZ1gw?=
 =?utf-8?B?RHFkaWhDWm5nY29uc2ZFZko4Z0Q2TExFa1EyMi9HZDhibUczVHVUMlVNa0RG?=
 =?utf-8?B?WXozQ2lpU3Q0b3BsbERvSkZwT0prQ1d0TTdFemVEUVV3eG16ZkR3bEt0WnM3?=
 =?utf-8?B?MXkyYm94emdZVkFyQWtweVlWYzZOSWdTL2FLaDFhYXRMWW5iK1QzWUcvNFh5?=
 =?utf-8?B?L2djN1JQZzJpNnhlTGJWSmErNzBGb1ZHaW5BWE1uNlpUVnptM0JqTjRpOXlq?=
 =?utf-8?B?Vmtuem04cmE2Ykhjdk41VGQ3eTZyK3B6c1U3T0Q3Ujh1Vlk4OXdGcEM4b0VM?=
 =?utf-8?B?UldVT1RmaTdSZGJ3M1diTlVHbUlDeTZ0ZEtwVzBObUV3TUNoclZJem9VYmdt?=
 =?utf-8?B?K0NleDFzaEZTQzNIeDRSMmJPbDgwdG5DVWxFWS91VUNQbDF2eXZNUmFYVUlr?=
 =?utf-8?B?R1c4QWdmZU9IN1NiOThxM3NVVjcwUzZ0YmE0a3Vod2pNUnpxanYxK2NJazQ5?=
 =?utf-8?B?UmIvWDlBT2FmN2N5dElsSlNKeklLb1BXOTVqTXhXU2NzZEdEek1iS2taR0tB?=
 =?utf-8?B?MW5aYUlqS2VZN1VrTWtoMzVKZk5LYTdvWTQweVZ0NVhHMFJYRXFzYUQvNVpW?=
 =?utf-8?B?UGJvWVVBRmxsellPdEg5Mmtad0Zmd3hRcE9LZDFSeDdTQnpZUThVajQyWVJs?=
 =?utf-8?B?SEEwMEN0MlRXajRsdkZ4NlZSTk5sZjNTQWR5QUlrcDlMMWxiNlNkSVpNOExo?=
 =?utf-8?B?UGlpRmVjTi9SMlZvdjY5dUx3ZlQ1OHZaQnZiaTVtRDEvYitRNnZjbHJKQzkw?=
 =?utf-8?B?RG15VE5BdW8wZHgrOXdqQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4c1dc3-4b3c-445e-b896-08d8d82a93c8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 18:41:05.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhxKb4ywRmjj/ndtZo93VyOBJpAPZa9cFx8u2I5df9c0St5FRhdWJQKI0to3gBrl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2205
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=797 clxscore=1015 lowpriorityscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102230154
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/22/21 2:56 PM, Alexei Starovoitov wrote:
> On Wed, Feb 17, 2021 at 10:18:08AM -0800, Yonghong Song wrote:
>> +			ret = BPF_CAST_CALL(callback_fn)((u64)(long)map,
>> +					(u64)(long)key, (u64)(long)val,
>> +					(u64)(long)callback_ctx, 0);
>> +			if (ret) {
>> +				rcu_read_unlock();
>> +				ret = (ret == 1) ? 0 : -EINVAL;
>> +				goto out;
> 
> There is a tnum(0,1) check in patch 4.
> I'm missing the purpose of this additional check.

I missed this one after I added tnum(0, 1) checking. Will fix in the 
next revision.

> 
>> +			}
>> +		}
>> +		rcu_read_unlock();
>> +	}
>> +out:
>> +	migrate_enable();
>> +	return ret ?: num_calls;
>> +}
