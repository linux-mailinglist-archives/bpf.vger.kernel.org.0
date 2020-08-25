Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1C25221F
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 22:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHYUqM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 16:46:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55548 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726158AbgHYUqJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Aug 2020 16:46:09 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PKjGFI019302;
        Tue, 25 Aug 2020 13:45:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=D0Jzhl9DQpN1oNQvZuTSgxAtCkX4AHhFpJpAXcbdBzE=;
 b=SYp7DUuNXxnmymbUd3RLkKaKWx1swRX917GD3lbf7tVdaLYTJ22krsAyYjS0DKhCo/TW
 TguxV6E3JPwoDwAslzuhj933l2gV5Odb97zuhFLTUIZTI7ldq9NM0L+OhiqlQT8w8wCr
 2Byyfu/0WNNj5JUBQ1UXQVyKKuVps+Un7Ts= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33313tr0mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Aug 2020 13:45:49 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 25 Aug 2020 13:45:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ti1khd+K7nP/uvhb8wRKbI8KMoFjpUY985SF/LifDRctzE7zil4PKKQf8C794Mn1neOA7etlOBL/aRb4CcZZuaWG3fu7oM2o844QfbVud76qkQURZA8PlqPbbOIDsbYsFBQY02Mn/MIyeFhKeUTWFqbZ6QUb4kfJ/dXH/5bzyXL/T0xjItGyH5VrjqTBxHB3PHtX/BZXrZz3PseWlYRpIVD5RHKOGrlAD+ED9YrEyQepT1lRnTnTD4Ba+/ZXGEkaztX/AzIkWR35px9DWJCF8oiSvlRrsJNi/HWHDQxouhrkFzJmNmhvE89cVNZJxnPi4gYEw42HIh4rMH05PzNZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Jzhl9DQpN1oNQvZuTSgxAtCkX4AHhFpJpAXcbdBzE=;
 b=mO+pwQshA7gQfugfGLT01gePO41DY3I6b887C9gSgsxIPp19N58tuuMahv9DCwhRT/KbuIKJJvz5CAJ5llHDdVYq2ycWPiD2T8dmDrbMz3CsoJBeWbN6vGdnGgpBL1qLev12fVyrYyy8QN5qPuVOELovct1lJLxNK774pwyWO2rF43m9WcCqxWSsLjKpN+5K93g6hEIUIiftEZIxptfauMadIM6IY8Oz5l/GIlPFYdPQWKCxJmuNrcQIr9jcE/yrDOAbSljnnDPzukyLlMTqNNliVaJiPoDmT01iSFUa8cVBgvHOT2xoLYzgx20pU6Lv3vQfzSvjJWdzUGWyCDLJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0Jzhl9DQpN1oNQvZuTSgxAtCkX4AHhFpJpAXcbdBzE=;
 b=O5DV/yvexJpVGGz5fiaP6Ymvhg5RaDUK1IPlrH8RGG+2kSOdNl91ukmFyynd+cETcodzxfjCL/1c2MU/+GC48lQHmGAUepQ3vdsovVUteR/43yQkuEFnmrlUu4XRE7B8m3RmgQUg1SewJjM55rz/wmfmGQlOVMhXS2TBPQMqwR8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB2888.namprd15.prod.outlook.com (2603:10b6:a03:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 25 Aug
 2020 20:45:06 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::9536:1fda:18bb:1abb]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::9536:1fda:18bb:1abb%7]) with mapi id 15.20.3305.032; Tue, 25 Aug 2020
 20:45:06 +0000
Date:   Tue, 25 Aug 2020 13:45:04 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH bpf-next 3/5] libbpf: Add BPF_PROG_BIND_MAP syscall and
 use it on .metadata section
Message-ID: <20200825204504.GA32347@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1597915265.git.zhuyifei@google.com>
 <b65c850c8e9f9ae8309c8a328a3d53ab76289c5b.1597915265.git.zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b65c850c8e9f9ae8309c8a328a3d53ab76289c5b.1597915265.git.zhuyifei@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: BY5PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::13) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BY5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:1e0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 20:45:05 +0000
X-Originating-IP: [2620:10d:c090:400::5:de11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efcdc766-1fb6-439f-49a9-08d84937bf87
X-MS-TrafficTypeDiagnostic: BYAPR15MB2888:
X-Microsoft-Antispam-PRVS: <BYAPR15MB28880B13A84BED742E18647BA8570@BYAPR15MB2888.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: US/rBIbDuczIGNOYjGj8bk+3kiotE05TA4ZhR9kT/EJbWSDAY0p5qjM4jjxqhri6oNBcmTX+IxYqvISDyZKAh8x9GiwyT+BVhv/6PVOm4RUo1qCOQOdm2vAkLTbdQv3OFYrjzcxSRaN17buW1uFm4oM/h+sgAmkbgB9cZSxKBXC5C9aFNnAyRyf31JXQlDzLBeP132Xf5euSWB4Xtowvt1DbR2QY19ScQUsaU17oA35EriVOfslkxiOUQ+z7OZjZCtAaZAsgb/nZH7b3lN9FXWoHHnUMPUP+BsqItCFIc+GG1Dl6wMg+akEEeq08QNZoBvy6piKXpe1AgjJ364ZW5+vlDmZGoApN1YVc6WS/ZLH3yl4aZOQUw0ewSt7k9TUA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39860400002)(346002)(376002)(186003)(66556008)(33656002)(86362001)(66946007)(66476007)(316002)(16576012)(8676002)(54906003)(5660300002)(6486002)(9686003)(1076003)(6916009)(4326008)(8936002)(52116002)(83380400001)(2906002)(478600001)(956004)(142923001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UFTAvWPPDq10q1KR95HXNbnfR/gOIpTWF9rfWaN30PSkQTy9758qCUD3CliaI1MSJT2M2tPGlX/FfAViSydSDGm96hPj2aT9zhLUgEAq8a8J8AxELptZwLd9Z2FZ9h7Sn6wjfJ5qxzlWgpmQ7sBM0N5nLBdVM/oagoC7lcK7Q4/rXc160wDOx/pzScGQrk07bfGZ5c5/IA/t5j1DLcqGB1vHsujJlLrMwAnWtNgnCcHJYSRNCiY0e3kjJXMesfsuyW2sjVkXea5POiYL2FPvdTYCqX3GsHrY8HV8JqW5wRPZSTNMNFzmk/kVkOmqYdBDxIhKbbhLPsw3dmZoCLrV5BFK3902/p1qGg6eBkCX7bmTZnBtc2fwefy4EFEuHLwQGPnvAPpRKGOMVhB92/GTu8qUyz/fQzLw2BC1bvqN/0LKRwZPB3GAXGuFq4CNTzkxHxkdROItVtA2WTIk6XnUG18ssNVG7K5IgZ35TYjh3iygA0KA7RNrNG51+yclof/ib5i1lB/yTTqGwsrSlDfkUPNu65dYs8PkUiOjwL9FZVCAdOx11s0lq12B5T2Z5k/R2nu4Bq1K+KsgwZJJnVuUxZ75QEO+XWxItEBPTq4ut9NmdAWUPRLGuwSA/1xMP2YN4MB0Hf7FGej8e3cenV/HrUuPukaiFAyth1IMs2FJAKw=
X-MS-Exchange-CrossTenant-Network-Message-Id: efcdc766-1fb6-439f-49a9-08d84937bf87
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4119.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 20:45:06.1796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SE7+T2B4aU7CZXkexv5upZ3S0/CIcTwv5iQ++7WEblQoiA2Yv5CnMED3uj+GDW2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2888
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_09:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=899 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250157
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

YiFei Zhu <zhuyifei1999@gmail.com> [Thu, 2020-08-20 02:43 -0700]:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> The patch adds a simple wrapper bpf_prog_bind_map around the syscall.
> And when using libbpf to load a program, it will probe the kernel for
> the support of this syscall, and scan for the .metadata ELF section
> and load it as an internal map like a .data section.
> 
> In the case that kernel supports the BPF_PROG_BIND_MAP syscall and
> a .metadata section exists, the map will be explicitly bound to
> the program via the syscall immediately after program is loaded.
> -EEXIST is ignored for this syscall.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
...
> @@ -1387,6 +1397,9 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>  	if (data)
>  		memcpy(map->mmaped, data, data_sz);
>  
> +	if (type == LIBBPF_MAP_METADATA)
> +		obj->metadata_map = map;

I wonder if the map should have BPF_F_RDONLY / BPF_F_RDONLY_PROG flags
set by libbpf?

At least in my use-case metadata should never change once the map is
created, neither from program nor from syscall side.

> +
>  	pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
>  	return 0;
>  }

-- 
Andrey Ignatov
