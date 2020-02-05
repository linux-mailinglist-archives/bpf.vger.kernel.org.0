Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B331152471
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2020 02:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgBEBXD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Feb 2020 20:23:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7922 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727674AbgBEBXD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Feb 2020 20:23:03 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0151Mlv5021042;
        Tue, 4 Feb 2020 17:22:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7efRz87FdMW0L+wZTIAtNArmTGg50GyuXfhFXrSdMtM=;
 b=rJHOvFWHJnFM19DAUc+7UjJC3L1RprP9i96M/yi+P58H5a+GvYDbIk5A9O8IzjbMG0bu
 n7tnJePwMsI8yVSs36eXGpgqbNvy45G/fkbg3Jn2A4eYCc0rnUb2jtTsTcPUQyUjqKqL
 OkPgUOxoQVaq6DIKPjCQLqt3HP66476zP7o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xyhndrm73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Feb 2020 17:22:46 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Feb 2020 17:21:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0DveGP2+zjdHUTYeoDi7tBTqxXQK/CzEFapfkEJE2TLwbXiBZ5JHS0iQI+Fe3Xadvo/AH9OrjMgGFuYp9mEdONPe7KSxh4L9vzkf/gFS6hbu5vEC40G4coOf8xGXEnD0/F6wO5Rb1B8r5kvUlxYMB7IXNAq/OFWNVHnKtERSVcZrBeDxkngvgEKESRzATtmslGUdWLWpB/PaAR9uzYYqlumMVyHzPuJc+WmPoHXkY1tA6daFA4UpHfYi00nEwIuyglKzI9Vibczb8MKgEmm8wjmkGap1Ee4fGNN/Zh0OSKB7Jc7bABP4JEKeqkyhVVpTF114wxwBO3LqLX4G/Pi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7efRz87FdMW0L+wZTIAtNArmTGg50GyuXfhFXrSdMtM=;
 b=VmhPLIxMFmFc1qS98hKMHDWE3fr5bKXUAx+2vAwXYclwmDQF84mxM0pyAilsVdvR/qCDab+RESdcZrCN2df2MLbK6XcD8IFFrvWYoiDvpN25/TTk9xqwNJOMZg1iVdzslJ4xdKO/xLV8lq2TtOYShOdb2wdnzFxKtszaa4hcLsgm0HKzYCLbviFtSmFpofa13Vs2ug+I1+piSvLNFzspWGn2PxD5Qv2J9IGjgM4LbHfHJlQzsUbOARQgtbv9C1PwQsNe5Rv646IHv7Ck7K+u86NLJypbkCYIXQUUE2quwAZSqh66wTrcxriQbL/n7SL4RfHpVwoyaN//oAtDJqrpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7efRz87FdMW0L+wZTIAtNArmTGg50GyuXfhFXrSdMtM=;
 b=O0Fp25yDlIbLlaSv23L4O7ry4WsjPAuxdruxw2SRgBobPGGasZFThc6OjLUkzbSG+TYpZfn/8W6Pb3rAWlwld5HR0vFFpdSug6Q8lP1V5sjdx1oS/MPJzdFtGG6RClCaekF1/N1OfQXnHhfsG4ieUrfQYuYN0AXUuTnBlxm1pSs=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB3241.namprd15.prod.outlook.com (20.179.50.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Wed, 5 Feb 2020 01:21:34 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2707.020; Wed, 5 Feb 2020
 01:21:34 +0000
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
 <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
 <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
 <20200131024620.2ctms6f2il6qss3q@ast-mbp>
 <5e33bfb6414eb_7c012b2399b465bcfe@john-XPS-13-9370.notmuch>
 <CAADnVQL+hBuz8AgJ-Tv8iWFoGdpXwSmdqHVzX5NgR_1Lfpx3Yw@mail.gmail.com>
 <5e3460d3a3fb1_4a9b2ab23eff45b82c@john-XPS-13-9370.notmuch>
 <CAADnVQ+m70Pzs33mAhsF0JEx+LVoXrTZyC-szhyk+cNo71GgXw@mail.gmail.com>
 <5e39cc3957bd1_63882ad0d49345c0c5@john-XPS-13-9370.notmuch>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <fe3e8178-c069-4299-10df-8c983388c48c@fb.com>
Date:   Tue, 4 Feb 2020 17:21:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
In-Reply-To: <5e39cc3957bd1_63882ad0d49345c0c5@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:300:129::14) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
MIME-Version: 1.0
Received: from macbook-pro-52.dhcp.thefacebook.com (2620:10d:c090:200::d22f) by MWHPR21CA0028.namprd21.prod.outlook.com (2603:10b6:300:129::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.5 via Frontend Transport; Wed, 5 Feb 2020 01:21:33 +0000
X-Originating-IP: [2620:10d:c090:200::d22f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46fad5ab-35f4-40cf-c4a5-08d7a9d9bd19
X-MS-TrafficTypeDiagnostic: DM6PR15MB3241:
X-Microsoft-Antispam-PRVS: <DM6PR15MB3241E33DDC29B9A94D00FE5BD3020@DM6PR15MB3241.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(396003)(346002)(366004)(199004)(189003)(16526019)(186003)(6512007)(2906002)(54906003)(6506007)(110136005)(53546011)(6486002)(478600001)(8936002)(4326008)(8676002)(81166006)(81156014)(966005)(316002)(86362001)(66476007)(31696002)(36756003)(52116002)(30864003)(5660300002)(66946007)(2616005)(31686004)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3241;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROwBY0jTLhQdopDgXUtpyZPEgDdTPgau1Z2SaUCRvV+habTX/pxq7Fhue0u64olExv9vgTL7Tgx6e/myckMDyYEKYY5GRTb8Imc11THA57c9ZKm3lXv6gN44rUm3LUydyLPeSilX5bL189T+L9cYPs0GO4GjtZCk3YSlWHBy4t0sX7v7aOA3HoVJKA2lKiIAT4Pk8mx8dhZ+lmZ3cpnoV4atb/UK+n0NEZEYkyOUiM9DpvsGEENDY6gqmA0VIwHJ+Ap0IhL0hgKSRY02QIz6xZgBFrMuh6fyFofdQk3kahxQGB5P2ez5uPitMeobXkrbj7pvBNwM1YWbbKWaFWwvGd/CoM6zxgbA0AoM2XY8cSSVCUvnqAhtyo+/FlWjD3tCE9ICy9eXNvXpy/6SQ43dxR804eqr92akv8rLP2eaDfBRXSkC8DxM7yFQeltfDFkb24tDF7L3SS/ZYLSa/N9GzG9Cr7wMNFSKXd2o0iqU7Ja+lFupN8oyryjiMAQWEiOsUF+krw41CWKTsTq0QypNRA==
X-MS-Exchange-AntiSpam-MessageData: dZ+VT1WAy9LBpfEdtsE/LZkSH40k2/Smznrt94JWwi+AgbtEuw+gc0rLq85kKcuir9lwRlMIOfIPrVvA+I6rroILFTEegEXC7Pas5rKmRjp+De6XJXUnQzgBm3VyTl/AgYFZp/S8bVw6psEAKG1WGx0hbqtqKTdQ76wfhLSprrc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fad5ab-35f4-40cf-c4a5-08d7a9d9bd19
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 01:21:34.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ywg30HpY3gsI91zVW+O5k4G014pHYk2dbYg8GYuM0ijlAEC7S4sZtg5VmH1EjUI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3241
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_09:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002050008
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/4/20 11:55 AM, John Fastabend wrote:
> Alexei Starovoitov wrote:
>> On Fri, Jan 31, 2020 at 9:16 AM John Fastabend <john.fastabend@gmail.com> wrote:
>>>
>>> Also don't mind to build pseudo instruction here for signed extension
>>> but its not clear to me why we are getting different instruction
>>> selections? Its not clear to me why sext is being chosen in your case?
>>
>> Sign extension has to be there if jmp64 is used.
>> So the difference is due to -mcpu=v2 vs -mcpu=v3
>> v2 does alu32, but not jmp32
>> v3 does both.
>> By default selftests are using -mcpu=probe which
>> detects v2/v3 depending on running kernel.
>>
>> llc -mattr=dwarfris -march=bpf -mcpu=v3  -mattr=+alu32
>> ;       usize = bpf_get_stack(ctx, raw_data, max_len, BPF_F_USER_STACK);
>>        48:       bf 61 00 00 00 00 00 00 r1 = r6
>>        49:       bf 72 00 00 00 00 00 00 r2 = r7
>>        50:       b4 03 00 00 20 03 00 00 w3 = 800
>>        51:       b7 04 00 00 00 01 00 00 r4 = 256
>>        52:       85 00 00 00 43 00 00 00 call 67
>>        53:       bc 08 00 00 00 00 00 00 w8 = w0
>> ;       if (usize < 0)
>>        54:       c6 08 16 00 00 00 00 00 if w8 s< 0 goto +22 <LBB0_6>
>> ;       ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
>>        55:       1c 89 00 00 00 00 00 00 w9 -= w8
>>        56:       bc 81 00 00 00 00 00 00 w1 = w8
>>        57:       67 01 00 00 20 00 00 00 r1 <<= 32
>>        58:       77 01 00 00 20 00 00 00 r1 >>= 32
>>        59:       bf 72 00 00 00 00 00 00 r2 = r7
>>        60:       0f 12 00 00 00 00 00 00 r2 += r1
>>        61:       bf 61 00 00 00 00 00 00 r1 = r6
>>        62:       bc 93 00 00 00 00 00 00 w3 = w9
>>        63:       b7 04 00 00 00 00 00 00 r4 = 0
>>        64:       85 00 00 00 43 00 00 00 call 67
>> ;       if (ksize < 0)
>>        65:       c6 00 0b 00 00 00 00 00 if w0 s< 0 goto +11 <LBB0_6>
>>
>> llc -mattr=dwarfris -march=bpf -mcpu=v2  -mattr=+alu32
>> ;       usize = bpf_get_stack(ctx, raw_data, max_len, BPF_F_USER_STACK);
>>        48:       bf 61 00 00 00 00 00 00 r1 = r6
>>        49:       bf 72 00 00 00 00 00 00 r2 = r7
>>        50:       b4 03 00 00 20 03 00 00 w3 = 800
>>        51:       b7 04 00 00 00 01 00 00 r4 = 256
>>        52:       85 00 00 00 43 00 00 00 call 67
>>        53:       bc 08 00 00 00 00 00 00 w8 = w0
>> ;       if (usize < 0)
>>        54:       bc 81 00 00 00 00 00 00 w1 = w8
>>        55:       67 01 00 00 20 00 00 00 r1 <<= 32
>>        56:       c7 01 00 00 20 00 00 00 r1 s>>= 32
>>        57:       c5 01 19 00 00 00 00 00 if r1 s< 0 goto +25 <LBB0_6>
>> ;       ksize = bpf_get_stack(ctx, raw_data + usize, max_len - usize, 0);
>>        58:       1c 89 00 00 00 00 00 00 w9 -= w8
>>        59:       bc 81 00 00 00 00 00 00 w1 = w8
>>        60:       67 01 00 00 20 00 00 00 r1 <<= 32
>>        61:       77 01 00 00 20 00 00 00 r1 >>= 32
>>        62:       bf 72 00 00 00 00 00 00 r2 = r7
>>        63:       0f 12 00 00 00 00 00 00 r2 += r1
>>        64:       bf 61 00 00 00 00 00 00 r1 = r6
>>        65:       bc 93 00 00 00 00 00 00 w3 = w9
>>        66:       b7 04 00 00 00 00 00 00 r4 = 0
>>        67:       85 00 00 00 43 00 00 00 call 67
>> ;       if (ksize < 0)
>>        68:       bc 01 00 00 00 00 00 00 w1 = w0
>>        69:       67 01 00 00 20 00 00 00 r1 <<= 32
>>        70:       c7 01 00 00 20 00 00 00 r1 s>>= 32
>>        71:       c5 01 0b 00 00 00 00 00 if r1 s< 0 goto +11 <LBB0_6>
>>
>> zext is there both cases and it will be optimized with your llvm patch.
>> So please send it. Don't delay :)
> 
> LLVM patch here, https://urldefense.proofpoint.com/v2/url?u=https-3A__reviews.llvm.org_D73985&d=DwICaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=VnK0SKxGnw_yzWjaO-cZFrmlZB9p86L4me-mWE_vDto&s=jwDJuAEdJ23HVcvIILvkfxvTNSe_cgHQFn_MpXssfXc&e=
> 
> With updated LLVM I can pass selftests with above fix and additional patch
> below to get tighter bounds on 32bit registers. So going forward I think
> we need to review and assuming it looks good commit above llvm patch and
> then go forward with this series.

Thanks. The llvm patch looks sane, but after applying the patch, I hit 
several selftest failures. For example, strobemeta_nounroll1.o.

The following is a brief analysis of the verifier state:

184: 
R0=inv(id=0,smax_value=9223372032559808513,umax_value=18446744069414584321,var_off=(0x0; 
0xffffffff00000001))
R7=inv0

184: (bc) w7 = w0
185: 
R0=inv(id=0,smax_value=9223372032559808513,umax_value=18446744069414584321,var_off=(0x0; 
0xffffffff00000001))
R7_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0x1))

185: (67) r7 <<= 32
186: 
R0=inv(id=0,smax_value=9223372032559808513,umax_value=18446744069414584321,var_off=(0x0; 
0xffffffff00000001))
R7_w=inv(id=0,umax_value=4294967296,var_off=(0x0; 0x100000000))

186: (77) r7 >>= 32
187: 
R0=inv(id=0,smax_value=9223372032559808513,umax_value=18446744069414584321,var_off=(0x0; 
0xffffffff00000001))
R7_w=inv(id=0,umax_value=1,var_off=(0x0; 0x1))

You can see after left and right shift, we got a better R7 umax_value=1.
Without the left and right shift, eventually verifier complains.

Can we make uname_value=1 at insn 'w7 = w0'?
Currently, we cannot do this due to the logic in coerce_reg_to_size().
It looks correct to me to ignore the top mask as we know the upper 32bit 
will be discarded.

I have implemented in my previous patch to deal with signed compares.
The following is the patch to fix this particular issue:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1cc945daa9c8..5aa2adad18c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2788,7 +2788,8 @@ static int check_tp_buffer_access(struct 
bpf_verifier_env *env,
  /* truncate register to smaller size (in bytes)
   * must be called with size < BPF_REG_SIZE
   */
-static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
+static void coerce_reg_to_size(struct bpf_reg_state *reg, int size,
+                              bool ignore_upper_mask)
  {
         u64 mask;

@@ -2797,7 +2798,8 @@ static void coerce_reg_to_size(struct 
bpf_reg_state *reg, int size)

         /* fix arithmetic bounds */
         mask = ((u64)1 << (size * 8)) - 1;
-       if ((reg->umin_value & ~mask) == (reg->umax_value & ~mask)) {
+       if (ignore_upper_mask ||
+           (reg->umin_value & ~mask) == (reg->umax_value & ~mask)) {
                 reg->umin_value &= mask;
                 reg->umax_value &= mask;
         } else {
@@ -3066,7 +3068,7 @@ static int check_mem_access(struct 
bpf_verifier_env *env, int insn_idx, u32 regn
         if (!err && size < BPF_REG_SIZE && value_regno >= 0 && t == 
BPF_READ &&
             regs[value_regno].type == SCALAR_VALUE) {
                 /* b/h/w load zero-extends, mark upper bits as known 0 */
-               coerce_reg_to_size(&regs[value_regno], size);
+               coerce_reg_to_size(&regs[value_regno], size, false);
         }
         return err;
  }
@@ -4859,8 +4861,8 @@ static int adjust_scalar_min_max_vals(struct 
bpf_verifier_env *env,
                  * LSB, so it isn't sufficient to only truncate the 
output to
                  * 32 bits.
                  */
-               coerce_reg_to_size(dst_reg, 4);
-               coerce_reg_to_size(&src_reg, 4);
+               coerce_reg_to_size(dst_reg, 4, false);
+               coerce_reg_to_size(&src_reg, 4, false);
         }

         smin_val = src_reg.smin_value;
@@ -5114,7 +5116,7 @@ static int adjust_scalar_min_max_vals(struct 
bpf_verifier_env *env,

         if (BPF_CLASS(insn->code) != BPF_ALU64) {
                 /* 32-bit ALU ops are (32,32)->32 */
-               coerce_reg_to_size(dst_reg, 4);
+               coerce_reg_to_size(dst_reg, 4, false);
         }


         __reg_deduce_bounds(dst_reg);
@@ -5290,7 +5292,7 @@ static int check_alu_op(struct bpf_verifier_env 
*env, struct bpf_insn *insn)
                                         mark_reg_unknown(env, regs,
                                                          insn->dst_reg);
                                 }
-                               coerce_reg_to_size(dst_reg, 4);
+                               coerce_reg_to_size(dst_reg, 4, true);
                         }
                 } else {
                         /* case: R = imm
@@ -5482,7 +5484,7 @@ static int is_branch_taken(struct bpf_reg_state 
*reg, u64 val, u8 opcode,
                  * could truncate high bits and update umin/umax 
according to
                  * information of low bits.
                  */
-               coerce_reg_to_size(reg, 4);
+               coerce_reg_to_size(reg, 4, false);
                 /* smin/smax need special handling. For example, after 
coerce,
                  * if smin_value is 0x00000000ffffffffLL, the value is 
-1 when
                  * used as operand to JMP32. It is a negative number 
from s32's
@@ -6174,8 +6176,8 @@ static int check_cond_jmp_op(struct 
bpf_verifier_env *env,

                 dst_lo = &lo_reg0;
                 src_lo = &lo_reg1;
-               coerce_reg_to_size(dst_lo, 4);
-               coerce_reg_to_size(src_lo, 4);
+               coerce_reg_to_size(dst_lo, 4, false);
+               coerce_reg_to_size(src_lo, 4, false);

                 if (dst_reg->type == SCALAR_VALUE &&
                     src_reg->type == SCALAR_VALUE) {

With the above patch, there is still one more issue in test_seg6_loop.o, 
which is related to llvm code generation, w.r.t. our strange 32bit 
packet begin and packet end.

The following patch is generated:

2: (61) r1 = *(u32 *)(r6 +76)
3: R1_w=pkt(id=0,off=0,r=0,imm=0) R2_w=pkt_end(id=0,off=0,imm=0) 
R6_w=ctx(id=0,off=0,imm=0) R10=fp0
; cursor = (void *)(long)skb->data;
3: (bc) w8 = w1
4: R1_w=pkt(id=0,off=0,r=0,imm=0) R2_w=pkt_end(id=0,off=0,imm=0) 
R6_w=ctx(id=0,off=0,imm=0) 
R8_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
; if ((void *)ipver + sizeof(*ipver) > data_end)
4: (bf) r3 = r8

In the above r1 is packet pointer and after the assignment, it becomes a 
scalar and will lead later verification failure.

Without the patch, we generates:
1: R1=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
; data_end = (void *)(long)skb->data_end;
1: (61) r1 = *(u32 *)(r6 +80)
2: R1_w=pkt_end(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) R10=fp0
; cursor = (void *)(long)skb->data;
2: (61) r8 = *(u32 *)(r6 +76)
3: R1_w=pkt_end(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0) 
R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
; if ((void *)ipver + sizeof(*ipver) > data_end)
3: (bf) r2 = r8
4: R1_w=pkt_end(id=0,off=0,imm=0) R2_w=pkt(id=0,off=0,r=0,imm=0) 
R6_w=ctx(id=0,off=0,imm=0) R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0
4: (07) r2 += 1
5: R1_w=pkt_end(id=0,off=0,imm=0) R2_w=pkt(id=0,off=1,r=0,imm=0) 
R6_w=ctx(id=0,off=0,imm=0) R8_w=pkt(id=0,off=0,r=0,imm=0) R10=fp0

r2 keeps as a packet pointer, so we don't have issues later.

Not sure how we could fix this in llvm as llvm does not really have idea
the above w1 in w8 = w1 is a packet pointer.

> 
> ---
> 
> bpf: coerce reg use tighter max bound if possible
>      
> When we do a coerce_reg_to_size we lose possibly valid upper bounds in
> the case where, (a) smax is non-negative and (b) smax is less than max
> value in new reg size. If both (a) and (b) are satisfied we can keep
> the smax bound. (a) is required to ensure we do not remove upper sign
> bit. And (b) is required to ensure previously set bits are contained
> inside the new reg bits.
>      
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1cc945d..e5349d6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2805,7 +2805,8 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
>   		reg->umax_value = mask;
>   	}
>   	reg->smin_value = reg->umin_value;
> -	reg->smax_value = reg->umax_value;
> +	if (reg->smax_value < 0 || reg->smax_value > reg->umax_value)
> +		reg->smax_value = reg->umax_value;
>   }
>   
>   static bool bpf_map_is_rdonly(const struct bpf_map *map)
> 
