Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3821A311F39
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 18:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhBFRyz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 12:54:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23068 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230251AbhBFRyw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 6 Feb 2021 12:54:52 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 116Hr2bf000337;
        Sat, 6 Feb 2021 09:53:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Z2yqGK2ySLVTirL6n8Y0FSJR7nnznprOgJx0CpQgALk=;
 b=KLqk1/xb39w7zI+SloRTKIxaPfMbUZnI44bg73P2CTlTkoAWNjYJXspfhc7c5few13Pj
 Nu1piNKvqbOK9ojcYPlqrc0hpWYQXcD2BXfrN3QhwwEGwka0RFjliAZWvX/Vud3W79lM
 9qNmYFe/CMAU2S0L5Wm17+MmbUPZSc/QanA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hs3r92pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Feb 2021 09:53:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 6 Feb 2021 09:53:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0JfGJ+zzuZz0jnEFqpPdrzV7v26kkRP5uITw2HvKvDAJUZusmIyZqhjyvRxwnXW/TGcz/rvk3+n9L+TG9YVbyhw2jqnil3MFhPYn9BrhTV2wVVYsshM9fccVTjoAVVV7xiJAYMJBpv65aQL1x0obkha4btgOHQd9ydGfdysF5m9P6nBjfbXmAwsncet5u3vyZpdfDnTHphDKItvxaMMHOucVuqWLF1v95hh/hOKN1u2Zb6XjLGQ/dPc3C1NN8W44z81vc0yzK+iGjFW9AubQrzvKUEaITUhd7iUAAs6Pns0nUXTaG5uGmTb4SDXQLL+AlTS/IrlbuEvoTqOYficVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2yqGK2ySLVTirL6n8Y0FSJR7nnznprOgJx0CpQgALk=;
 b=WRTBclGztfi8g/QaQV2sjcGL0E1OadEvxRQcl4eqbH6reZj4LL3UmRI95Sd3bv6cixvhzVHdAMDyRbo7X00xPiHhKYHO2Evn4LDHc+IoMgPmBi/SshWGCMJi9k+r0u0W4YgBOlwypL5zSd1yq71wgGGADa9VZgEtl5qQ4KcB2aJbMKtfOAd9pf+JLceR5ak7CpeIHh52O46Bw+gGU/8RX2cBGXDNAcPVtUmJSG6ueU/infaytj0n6Ei8UpVASRYKpYFiM8HHaOGYw5ndYw1Ddgve/+CYJ1WHlzv0u6v5uCLZr4E8J/KPQyUBISjqqzoythrdAs7fPSpLpF6eWUuiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2yqGK2ySLVTirL6n8Y0FSJR7nnznprOgJx0CpQgALk=;
 b=YLCduVoSEtZjBIznF/LgyRuqG/j/N1Chd0VoQJgseYQo8MN6DOoIaqJYgWbprmGsAlzupaprGQW3y075x+Eig4N6A8FSAxSIBmV8yMbboyWJMNt4HLpRU+r9LDLT6SbHAhc5pbFG6+uRDKc+meTeWvGlwvNKQ5nzreSP8fogYQQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2488.namprd15.prod.outlook.com (2603:10b6:a02:90::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.27; Sat, 6 Feb
 2021 17:53:36 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3805.028; Sat, 6 Feb 2021
 17:53:36 +0000
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Mark Wieelard <mark@klomp.org>
CC:     <sedat.dilek@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
References: <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com>
 <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
 <d59c2a53-976c-c304-f208-67110bdd728a@fb.com>
 <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
 <CA+icZUWFx47jWJsV6tyoS5f18joPLyE8TOeeyVgsk65k9sP2WQ@mail.gmail.com>
 <CA+icZUUj1P_PAj=E8iF=C4m6gYm9zqb+WWbOdoTqemTeGnZbww@mail.gmail.com>
 <CA+icZUWY0zkOb36gxMOuT5-m=vC5_e815gkSEyM45sO+jgcCZg@mail.gmail.com>
 <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com>
 <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com>
 <20210206162419.GC2851@wildebeest.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3f5a00ef-1c71-d0da-e9fd-c7f707760f5c@fb.com>
Date:   Sat, 6 Feb 2021 09:53:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <20210206162419.GC2851@wildebeest.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:e118]
X-ClientProxiedBy: MWHPR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:300:ee::26) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::103e] (2620:10d:c090:400::5:e118) by MWHPR04CA0040.namprd04.prod.outlook.com (2603:10b6:300:ee::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Sat, 6 Feb 2021 17:53:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 622f4fee-1863-43c0-3d35-08d8cac82070
X-MS-TrafficTypeDiagnostic: BYAPR15MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2488C90614FA4E20BA06B1A1D3B19@BYAPR15MB2488.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/15QNXZtwqexcYS2p4s5nA5uy7fl39DL7lWuIyjQ00rX2BGH8CNMggirWd1zgT7vS+oi8QdG1o19qmxug7FfaHkr7YLQMjxAOVYyOXJ893XTEw5sIutKvOE6kviq6NhBl3ETAHTovM3vCG/2iX8kDbLg8tkMyvIRwgSM8M2jMMgtt0pvQ1s4DflcJDG34r6dIcELLY4gpaYizmp3ujY4Mw4Af/HI01fvGj9vRkxhpf2HAqPHBvMJwGgxGjzpkdHERUkfytasl0PoBH46Kvmlc5Fd1Xoclol8K4wcUYLmdsTSfaa8434j7ML6UU37GITjhlVAOwBWpH2g7ImE6yPigXwRedcbq9/FVNYFz7f6KxiuoxjdwvLfmr8i0mxu2uQPu7aFESKf/wHYcbv8pvmBU57KYMSB5fR0n99iaVnSOFAAP4niz6asyb+dps8M0nEMbxQ+OIQj6rMLX2WPQKWVQc+TWejU728eEbuESPAwPz3h7n5x/JAauNpawm0ZZBGyuCKx7a6wYl/qu6jhfsMvfZL2yogfbzky/RQ354a2VfEQSP/f8lFx0VAcHaQGhjoHzU3iMS8PwySv4n6qovU3op1iyBGsK/Z60HZpm7m0Bo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(39860400002)(396003)(54906003)(7416002)(16526019)(6916009)(52116002)(8936002)(53546011)(6486002)(31696002)(478600001)(2616005)(66556008)(31686004)(36756003)(66946007)(66476007)(86362001)(8676002)(2906002)(186003)(316002)(5660300002)(4326008)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WGdSSC9rLy9rRVdSRWNzTTZFVFN6Q2ExQi9PWERBSTBVYTk2MkV6Ny9yeWV4?=
 =?utf-8?B?aS9KZFVzdVBUcXZXbFVVOVVjWUF5SldqQ1BVdzlzbS9kVWg0bU5XZWRTVnRh?=
 =?utf-8?B?NXNRSkVodDZrS0xxQS80c0NGNS9yNm1PalhjOE04OTMwMHlwa1RZZE5OWU1Y?=
 =?utf-8?B?V1haK0VtVXpxTjZRZGVUYTdZK2dPemJUWlQ5SWJwSFdLNU1yaGZrdFJ3NWpn?=
 =?utf-8?B?NmYyVmtLdnZLejNmRkd4NEVLb3RJR21LS1d2RElpVDBGdFF3Q3c3K1NMeEJN?=
 =?utf-8?B?U2d0enpSVWt0RmlsUENtSVhndWlveG1yaWdLL3ZkSFc1ZnZWcHA1WlNtZGo1?=
 =?utf-8?B?Q3ArV2JIeUY0dzFmOW5lMWRNWGY4VnRNKzdkUmI1TmZjZUV0U2lHN1N5b2lt?=
 =?utf-8?B?ZEc1aDErb1FBWDd2MVVJRzhzTTNVcDRTcGRIVXpIUWpDbXg0NjV0QnFVU2NS?=
 =?utf-8?B?eVRKUE0zSnNxVE05TFA1KzZFMVRwbHdDWmNnOWovd1NISzU3dnA4S21pUUh3?=
 =?utf-8?B?WVk4TUNDRGNYYTU5dUYySjJ5SGV5MVgvRGZGd2FYNEJYYTEvcG04ZmtWd3do?=
 =?utf-8?B?czhobHRlOHJYdTNHaWIxb1h2clR3anBlM3BSV3RKMWFtVFZZT01iYUpXbGh0?=
 =?utf-8?B?YlFXUUprZlpqMWtDTWM3YkJWc0FNSDdmYnVCMlcvOWFjTjAvOFgrOGF4MzZR?=
 =?utf-8?B?ZHdlUDJNRzZLak1IVkMzSkN1OGFmajl0ZEN0Qk5NL2VqSVRUWHBEUkcvTm9h?=
 =?utf-8?B?bEFNU1RuTmZPeW11Qjk4UVppdDR5Tk5yU1dMQktuNzlGQkNBQTJlTEhHUlFM?=
 =?utf-8?B?SFdENGlvd2xpcjdpcmFaclJSaFk0c2EyOWo4ZC9Rc3VOVGFjY1NNeG5VcVg0?=
 =?utf-8?B?b1VIWis2UzBzUmZlYWUwTjNma3BKWnp2RVBQdHd3TzdDMElQQ2p3alRBZDgv?=
 =?utf-8?B?SndPKzVzNytjOTNNL20wYVlwcVdQa0NvamNRRnNSR3E2NUNKNGVtYnlYN1l4?=
 =?utf-8?B?Um41Qzl1NkNWUmVzVlJadW5UWUpZZHp2UURwMG5GeHBuM3BUemJ0WkpLMFNP?=
 =?utf-8?B?OHprbHV6alYyWFIzK3ZVVzdZYVVvVzBoYUs3aFBoZ0V6ZUlCY3hJeDBPY2Nv?=
 =?utf-8?B?TXN2VE90N3Q0U0RoZWhCY0RybUhqQ3I0UXJsaHRHRU13Nm5pb2ZMclpaK3BL?=
 =?utf-8?B?cEkwa2ZyRnkvM1NDYkp2dlhlTHhpd0taVFdvaXZxV1ptOURzMGFUQXgra3Vv?=
 =?utf-8?B?cHN0RGFxdzhid3d5YW9KaTUwdC9pWi9VYTg4dldhVDl1bUdmbnhBWmJyd0Zp?=
 =?utf-8?B?QjlmdU0zNGZ3WkVnaXRvMlU3ekUvQlg1VlNQYkRKeU5mL2swbTQrYktHL2ht?=
 =?utf-8?B?QVJYL1FOa25JaW94UEppNFljRmM2Y3FnY2xYc2gvOG4rSHd2eXhVRGtPS3VX?=
 =?utf-8?B?L2dCdlkyYTZ6TDc2NSt1US9wTXNFajNmR2VTYkx1YmkrUFBWclBxL2pYaGFp?=
 =?utf-8?B?ek8xbnVabW5RZjVyQnIvdzR3VVl6d1B2RnlFRGRnVE9nZDhtMnQ2b3Z6R25u?=
 =?utf-8?B?aUhtd240QUdaREtEKy8wb2t4ZXd0cC8yNzFkbDhqbVRLU0hwMTB1MU1lV1Nn?=
 =?utf-8?B?bXk1ankxUXRLbkRZSThOM1RQcTdVU1pWWFZySnMzMWZTQlQ4U0o3dkpzRjYv?=
 =?utf-8?B?RnRHTUV4K2VBRWowejB2aG1HbUV6WFkxK2RtSW5RaldzM2l1ZUdmdVZieU9o?=
 =?utf-8?B?cjdzU3pvL3VDSmQ5dWh4QzVFeldyS1RaNnoyYmQ1NEJyZkljdVArMU45OC9T?=
 =?utf-8?Q?qfmFRua9CFE/3mGnJhfu5i1GnXO4Jpfje15Fk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 622f4fee-1863-43c0-3d35-08d8cac82070
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2021 17:53:36.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3snGZ/9la3FJ2/AliH+PbEH63rg4blNW7zEpXekmi1jkEAcZD/FDJ/wgywj8ZefD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2488
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-06_06:2021-02-05,2021-02-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102060130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/6/21 8:24 AM, Mark Wieelard wrote:
> Hi,
> 
> On Sat, Feb 06, 2021 at 12:26:44AM -0800, Yonghong Song wrote:
>> With the above vmlinux, the issue appears to be handling
>> DW_ATE_signed_1, DW_ATE_unsigned_{1,24,40}.
>>
>> The following patch should fix the issue:
> 
> That doesn't really make sense to me. Why is the compiler emitting a
> DW_TAG_base_type that needs to be interpreted according to the
> DW_AT_name attribute?
> 
> If the issue is that the size of the base type cannot be expressed in
> bytes then the DWARF spec provides the following option:
> 
>      If the value of an object of the given type does not fully occupy
>      the storage described by a byte size attribute, the base type
>      entry may also have a DW_AT_bit_size and a DW_AT_data_bit_offset
>      attribute, both of whose values are integer constant values (see
>      Section 2.19 on page 55). The bit size attribute describes the
>      actual size in bits used to represent values of the given
>      type. The data bit offset attribute is the offset in bits from the
>      beginning of the containing storage to the beginning of the
>      value. Bits that are part of the offset are padding.  If this
>      attribute is omitted a default data bit offset of zero is assumed.
> 
> Would it be possible to use that encoding of those special types?  If

I agree with you. I do not like comparing me as well. Unfortunately, 
there is no enough information in dwarf to find out actual information.
The following is the dwarf dump with vmlinux (Sedat provided) for
DW_ATE_unsigned_1.

0x000e97e9:   DW_TAG_base_type
                 DW_AT_name      ("DW_ATE_unsigned_1")
                 DW_AT_encoding  (DW_ATE_unsigned)
                 DW_AT_byte_size (0x00)

There is no DW_AT_bit_size and DW_AT_bit_offset for base type.
AFAIK, these two attributes typically appear in struct/union members
together with DW_AT_byte_size.

Maybe compilers (clang in this case) can emit DW_AT_bit_size = 1
and DW_AT_bit_offset = 0/7 (depending on big/little endian) and
this case, we just test and get DW_AT_bit_size and it should work.

But I think BTF does not need this (DW_ATE_unsigned_1) for now.
I checked dwarf dump and it is mostly used for some arith operation
encoded in dump (in this case, e.g., shift by 1 bit)

0x000015cf:   DW_TAG_base_type
                 DW_AT_name      ("DW_ATE_unsigned_1")
                 DW_AT_encoding  (DW_ATE_unsigned)
                 DW_AT_byte_size (0x00)

0x00010ed9:         DW_TAG_formal_parameter
                       DW_AT_location    (DW_OP_lit0, DW_OP_not, 
DW_OP_convert (0x000015cf) "DW_ATE_unsigned_1", DW_OP_convert 
(0x000015d4) "DW_ATE_unsigned_8", DW_OP_stack_value)
                       DW_AT_abstract_origin     (0x00013984 "branch")

Look at clang frontend, only the following types are encoded with 
unsigned dwarf type.

   case BuiltinType::UShort:
   case BuiltinType::UInt:
   case BuiltinType::UInt128:
   case BuiltinType::ULong:
   case BuiltinType::WChar_U:
   case BuiltinType::ULongLong:
     Encoding = llvm::dwarf::DW_ATE_unsigned;
     break;


> not, can we try to come up with some extension that doesn't require
> consumers to match magic names?
> 
> Thanks,
> 
> Mark
> 
