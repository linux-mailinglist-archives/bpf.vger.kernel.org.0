Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0F22CE540
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 02:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgLDBnZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 20:43:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35870 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbgLDBnY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 20:43:24 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B41gcEV031690;
        Thu, 3 Dec 2020 17:42:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=maCqYrMA0/b40Ug0Y9zZ/ebkD7H7aZ8MFO0Lnj0gpZw=;
 b=Ba+gl7puc6nJxH2bHfsMgCq88kKyO1NqcI7nlgcBOYTrh6dKHgIyVtEJDxNszEpIxanH
 MYDxKjShZgNIAMjILv8v7IUVrg9EAbMZdonJlDh7skZB84xlsJk6NYly59MUuCC2r/VA
 isMajaw0So/L0txUjsZ2G561ULy30DTQITk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 355vfkjae0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 17:42:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 17:42:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATZFbV3nkZkum96GHTYJ3dub4XAAX7/V/sVxkci/qQ0J4+Mi2sL8gBNCJtN3MgQkQb3Okc26ksFviSQyPCZDV5+qpqjOUlykP4K74rl88tGZ57KUahoHp50VV516vbhBToQefQ7LtiHs2t1Ye97qYS56YbUoLGkvhIqSBV+R3GWglkaNdVubxfiPfLUEAFzggQ9BjDoxdwMctR7TinfOGgC0WpGq0vvirRMXqr8CbXGQ0TN0v6TtB6nanDPtDxvwLro3c/oCcvDZ1l9P7iczOf/otGco0/y3JV9RSWMNA+P3e5PeSdz0rG2Fkr7ut4uMyIl1P/AjK0qgM/tBDwAhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maCqYrMA0/b40Ug0Y9zZ/ebkD7H7aZ8MFO0Lnj0gpZw=;
 b=nTvFtYNxnL1H0eFokl5gRTXWRGLC+KlwLTGaeUZBNKekmtiM9T0OVKsiVPtR3+okcdKzf70yehYd0YnNVL1AK1ZOh5A2yGVtsi6Kcgme7FEDCv54az9XkkYQl5lq3wcSYOvdbfDNU0u7XkqJ/bJRmv+zY3Ab1Q8sX8zrE5muMC9+DaO2FUZxAgP4BV2opLmYDG8lUE20DQcTHMgh1yOA3O94GuvtVjZiXhGMJLCO5uXVui8sax0tpxBbjaVUGXgeAcQDtztfhMxES72QEFY/iEmgq9uNYFK7d+oFgOWC3agy9OvkAj+sut1jwrqXFL+vntRJVBqZiGJKcu1Pp/EspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maCqYrMA0/b40Ug0Y9zZ/ebkD7H7aZ8MFO0Lnj0gpZw=;
 b=S3PeQ5sZaKTIBKXhUAq5li/ZrAE7CWm+L6DK73WtyGW5WLfhTPJmNA6fyij1byq2S1TCTD6WN5TsASnNn0/7Qu+/2SkBspJoQAnIGRM2ls7qo9EFZP1RNGvzsL2E/veTk6w78jfzwv1SLr7Z470Wz9yEK2qYfs5qKoRitoE6Er4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4248.namprd15.prod.outlook.com (2603:10b6:a03:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Fri, 4 Dec
 2020 01:42:32 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 01:42:31 +0000
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     <bpf@vger.kernel.org>
References: <87lfeebwpu.fsf@toke.dk>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com>
Date:   Thu, 3 Dec 2020 17:42:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <87lfeebwpu.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:f05b]
X-ClientProxiedBy: MWHPR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:300:ae::13) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:f05b) by MWHPR14CA0003.namprd14.prod.outlook.com (2603:10b6:300:ae::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 01:42:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33134b09-5145-4a25-7e68-08d897f5dd76
X-MS-TrafficTypeDiagnostic: BYAPR15MB4248:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4248D3018F62F6A09151DF0ED3F10@BYAPR15MB4248.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l44GxASknP64DR9flnBZFkRhDn/2E7QMLz3NVlt8uKJmW4RTM14SCBa2RVEurBLS933/Tgbu8mJ23seqENZneb7HO0kGgHVKltw1FEPm6IAIeMZ25e+Eu5/O8Obv/esBoeQlCclcTLtyE3TjTl9J9sV2GcGi/Ljsgs/WlvgWaOaMjTXdV+qSgF8MriLK9pPoaMS/GjJ8DMPmHnUR8GwRPY/fHP7mk2fOqbCIhxaDM1Yj0VbIp5FIem5jiGJJwT5DnSdkMRAsX9LP/FJGTRQh1KAHrUN2HAwIwOlcGjYF2QHIFa+RImiAWdNRLLtNO8aWDSoVvfTN98srwo+J6M4F2P+aycktFYjDC2MfS5k4VVE8V6bSJnWv92bS9RU12NPojTjgKrOU8to4Tzc9v42Is6n56qlyq+gG6DVuiuh7fVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(39860400002)(366004)(53546011)(2906002)(83380400001)(66574015)(478600001)(52116002)(6486002)(8676002)(2616005)(4326008)(16526019)(8936002)(110136005)(316002)(31696002)(31686004)(5660300002)(86362001)(66556008)(66476007)(186003)(36756003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dU9ibDlwaUJSY2h4cHRyZHhJbU1tRTNXUnpZTkZKbTFUSWROb3c5VE14NzNG?=
 =?utf-8?B?L2IySzAxeVNaVG9sT05lKzdibmNPMWNwK05ObWM5aGhHNVRncjBwVnhhU3Nk?=
 =?utf-8?B?QlppQ25na3AxQnlTZXhjZnFIeWxWSTdtQkpLSEQ2QVZHYkY2WWIveU4zRFQ1?=
 =?utf-8?B?Z3BaUDZraXA3eWwwNEpQN3k4Wm1sbEpLdFJBc1YwUEN2dlVzSnZXV3R3MWc3?=
 =?utf-8?B?VU9kSlVjTW5KZE5CNmYzR3RUdWtoeGtmaUZtNXVTYjg1S05mWjVGWFdMM0Rh?=
 =?utf-8?B?RnZqYTVIcjM4TGF5TTdDbnRKMzNYQzBqekFkL1JZalZaMWREblBBajdleERY?=
 =?utf-8?B?NUFaKzB1WWlmaWk1bXp0KytrNjdTRFR0TnBEamRqNlQxWTI5Z21aVFZmTEVa?=
 =?utf-8?B?WDRjbUVpMTd3ODZoei9vdVZ2NGxOZmd5M2p0QkxlNnNKS3I2TjM0a3E0aHl2?=
 =?utf-8?B?QzQwbHFweTNYejVtbFFja3E3YWpaRkxrWFg1b3VORm1jOVdvLzM2UVdFR3dK?=
 =?utf-8?B?K3RSS0xXTURXQ2tYdkluQ29lL3IwdkxZajd6RW92d001RnV6dkRFS01CR0k4?=
 =?utf-8?B?WWlZcW9pRTlzYmNkVytNL25XajVkZStXbFdJUjZ1RnNYZjgvVy9BSzBZdmVJ?=
 =?utf-8?B?S3lRMnNsYnZBRS80YzV2c0pWdUNFRDJqejRHaSs2VXNCNzBTeXIxZFViMGdz?=
 =?utf-8?B?MVlCM1BKcm5ET3NWaElMUk9LTVZVd0ZCeFc3MUFFTW9lVXEwSlBTeUMrSXBS?=
 =?utf-8?B?SXo3clFaMlpVMDMzQWNSSHFjcGxYNGIxbXFydzl0cXQweS9RbThYVU1YTUJ5?=
 =?utf-8?B?MWNHZjIzUXF2cnZHUUpSUnpKemRydmVYV2twc3Q2V2Z6UkNjbi9USkVSK1lO?=
 =?utf-8?B?WlNEc1g4N0dOejdmTk5QM1hEc01JTXFDYWZtUHBGbzBJTVJBQ1lieE9JN004?=
 =?utf-8?B?VFJjeG05cXBWTWFMUmNoRUQrU3JvdVZ4c2s4bmpkYmdOUTliMjUvZWt3U3Q5?=
 =?utf-8?B?Q0sweElUTnQwSWRPOUZWQjUwZzRKRnJEWjVzWlhibHlNL3dQNGNUcG1NL3Zr?=
 =?utf-8?B?Z3c3ZjZOR0twSDZDMjQvUldwTWtDT09HdGNxL1N3VDZzQUNIaEV3dUJZVVh6?=
 =?utf-8?B?WGdvY3dDZjJkaXNTeDN1QWdQYlA5a3JvSzZVNXVvL29GOEpVZWoxL3hzdit6?=
 =?utf-8?B?dmlZdU1PUHM5bHVsZGhHNWdRSlRNdER2cWhFdzBWWXdXUVluQlZiMFpXVGNM?=
 =?utf-8?B?Ti9KSXJZdU1aTk44MldEOFYyZExZeEt6K0l3MHJVNytvQ1JVTGtNNEJlM1Yx?=
 =?utf-8?B?T1dyMkFRUkxHTGdBaURidDdZYmpGeWNkNVEzeHp6Z09uTkM2M2s5SmUzOVVq?=
 =?utf-8?B?MXprWVZxRG85b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33134b09-5145-4a25-7e68-08d897f5dd76
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 01:42:31.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++mmrux7DdfOenBvyv6zXsu7cwMJBWY1HSiBCokJy3bQK1kFZOmK2jlVx2GiHsRX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4248
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_15:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012040007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/3/20 9:55 AM, Toke Høiland-Jørgensen wrote:
> Hi Andrii
> 
> I noticed that recent libbpf versions fail to load BPF files compiled
> with old versions of LLVM. E.g., if I compile xdp-tools with LLVM 7 I
> get:
> 
> $ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv
> Loading 1 files on interface 'testns'.
> libbpf: loading ../lib/testing/xdp_drop.o
> libbpf: elf: section(3) prog, size 16, link 0, flags 6, type=1
> libbpf: sec 'prog': failed to find program symbol at offset 0
> Couldn't open file '../lib/testing/xdp_drop.o': BPF object format invalid
> 
> The 'failed to find program symbol' error seems to have been introduced
> with commit c112239272c6 ("libbpf: Parse multi-function sections into
> multiple BPF programs").
> 
> Looking at the object file in question, indeed it seems to not have any
> function symbols defined:
> 
> $  llvm-objdump --syms ../lib/testing/xdp_drop.o
> 
> ../lib/testing/xdp_drop.o:	file format elf64-bpf
> 
> SYMBOL TABLE:
> 0000000000000000 l       .debug_str	0000000000000000
> 0000000000000037 l       .debug_str	0000000000000000
> 0000000000000042 l       .debug_str	0000000000000000
> 0000000000000068 l       .debug_str	0000000000000000
> 0000000000000071 l       .debug_str	0000000000000000
> 0000000000000076 l       .debug_str	0000000000000000
> 000000000000008a l       .debug_str	0000000000000000
> 0000000000000097 l       .debug_str	0000000000000000
> 00000000000000a3 l       .debug_str	0000000000000000
> 00000000000000ac l       .debug_str	0000000000000000
> 00000000000000b5 l       .debug_str	0000000000000000
> 00000000000000bc l       .debug_str	0000000000000000
> 00000000000000c9 l       .debug_str	0000000000000000
> 00000000000000d4 l       .debug_str	0000000000000000
> 00000000000000dd l       .debug_str	0000000000000000
> 00000000000000e1 l       .debug_str	0000000000000000
> 00000000000000e5 l       .debug_str	0000000000000000
> 00000000000000ea l       .debug_str	0000000000000000
> 00000000000000f0 l       .debug_str	0000000000000000
> 00000000000000f9 l       .debug_str	0000000000000000
> 0000000000000103 l       .debug_str	0000000000000000
> 0000000000000113 l       .debug_str	0000000000000000
> 0000000000000122 l       .debug_str	0000000000000000
> 0000000000000131 l       .debug_str	0000000000000000
> 0000000000000000 l    d  prog	0000000000000000 prog
> 0000000000000000 l    d  .debug_abbrev	0000000000000000 .debug_abbrev
> 0000000000000000 l    d  .debug_info	0000000000000000 .debug_info
> 0000000000000000 l    d  .debug_frame	0000000000000000 .debug_frame
> 0000000000000000 l    d  .debug_line	0000000000000000 .debug_line
> 0000000000000000 g       license	0000000000000000 _license
> 0000000000000000 g       prog	0000000000000000 xdp_drop
> 
> 
> I assume this is because old LLVM versions simply don't emit that symbol
> information?

Could you share xdp_drop.c or other test which I can compile and check
to understand the issue?

> 
> Anyhow, the patch series that introduced this restructures the program
> parsing some, so I wanted to get your input to make sure I don't break
> things when fixing this regression. So what's the best way to fix it?
> Just assume that the whole section is one program if no symbols are
> present, or is the some subtle reason why that would break any of the
> other logic for BPF-to-BPF calls?
> 
> -Toke
> 
