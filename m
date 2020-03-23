Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7651C18EF83
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 06:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgCWFiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 01:38:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3004 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgCWFiF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Mar 2020 01:38:05 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02N5ZgHV019634;
        Sun, 22 Mar 2020 22:38:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lGYdMG9+xPqxj+A+v04h60iBSs1jI1nQ7P0SV/x0yoI=;
 b=Eyhcy097/F20G9Mz+bO8zVszqKXL1jSjjxF7ryjSX7ulL8RKbpjgyUJb1ITeFiGLalRn
 Z4HjOTDK7/Gp00R4Zab2xf2aYs1MOfhxUX9TaugkQxZBKm2aDwdL/Tcjg6zL6PSAqunq
 dHKgyN6MjO6mcpqrkWbeqPcltFZ7d2pnPLg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yx2r4kbhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 22 Mar 2020 22:38:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Sun, 22 Mar 2020 22:37:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfdZtZ2luL81Vv0zO0tc7Qq2XuvJxkcAouseae+q5UJRRAqP3xJl5/0fBxwcX88tE3/4wahx0JN6VNDkXG4vb5qhydRdS8rsQNZcfZqovfyBqJ5tUxs7hm/WlpmxQrJLeGQVJLi5MLlo3RchVDrMHPvOAh3LGk7cMZKlpzOUQbH/AaLAGvSTMRbZ/z5xzmXEETue1f4R5mW4gda04u7riRapaopLLXd7oiV42qqXkuVxdjfapb/7lUEEmUIX0Fkzv/gNFWSFWKtxvYWTWlSuex01cGxI+PF7C+4e6P949O8IJBOud4fqLiwI4KunbT2DpDlYiNUdBF0O5d+eu77djQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGYdMG9+xPqxj+A+v04h60iBSs1jI1nQ7P0SV/x0yoI=;
 b=I3v9byrdUZi/ztCuIAILW6jf2eRO8UbJuaXIqMk+z0xBNZTJHKn/AOe0IkvQjsTdrIj1LFjKg2y5fd1gHHUNtDsfKx2m7I4/GyiFRfgR3wW6QlpeOk1mYz3EJlzXQ6250/DcSToLUm6AXbrwV2V5UoNkj6RP8Aq2mucWx2BDFPMwV9SJb1VnDPoIxz/8G5Pn1UYtE93rj363kLOR0pHEkqgGvCcATAyszP0GrSfMN6DcXD0+zk6yJ+NBFK/n4kcdlE8S+QO8FR2visgUmqNbaZ63rxUuJ+Js+mAYXn9+EPSA6LCQOX6v1MtSCjJ6OF35MlDxkmiQXi1pp3ExX+QUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGYdMG9+xPqxj+A+v04h60iBSs1jI1nQ7P0SV/x0yoI=;
 b=eaCUR4WE6ZuDjkDbkwJblwOWAcziqIqHUdJZy9wbn2juYi+LjFVmvT+X1hi9r083w8t0DlwJ5JxY2lzhP30LtuCw3Jqw1+gdTRAifWRUoVYpZE0JoaX2vve43xA35Zo5PP0AQsnd0HdIkU2qrn9cK74dJy79+fd9qgQ+AJfyce4=
Received: from MW3PR15MB3883.namprd15.prod.outlook.com (2603:10b6:303:51::22)
 by MW3PR15MB3865.namprd15.prod.outlook.com (2603:10b6:303:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Mon, 23 Mar
 2020 05:37:58 +0000
Received: from MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98]) by MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98%5]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 05:37:58 +0000
Subject: Re: using libbpf in external projects
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, <bpf@vger.kernel.org>
CC:     <nicolas@serveur.io>, <linux-kbuild@vger.kernel.org>
References: <CAHmME9ptzBzzn+jOo=azZagB=TTFbc2vzdcYurfsE0_1nvKF+g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <50c6bd77-fb16-852a-adcc-3976550f6f81@fb.com>
Date:   Sun, 22 Mar 2020 22:37:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
In-Reply-To: <CAHmME9ptzBzzn+jOo=azZagB=TTFbc2vzdcYurfsE0_1nvKF+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0087.namprd19.prod.outlook.com
 (2603:10b6:320:1f::25) To MW3PR15MB3883.namprd15.prod.outlook.com
 (2603:10b6:303:51::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:400::5:76c) by MWHPR19CA0087.namprd19.prod.outlook.com (2603:10b6:320:1f::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Mon, 23 Mar 2020 05:37:57 +0000
X-Originating-IP: [2620:10d:c090:400::5:76c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75396755-2c68-4052-868c-08d7ceec582f
X-MS-TrafficTypeDiagnostic: MW3PR15MB3865:
X-Microsoft-Antispam-PRVS: <MW3PR15MB386557A4B4D4E052728E09C0D3F00@MW3PR15MB3865.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(366004)(346002)(39860400002)(199004)(478600001)(81156014)(81166006)(52116002)(66946007)(6506007)(86362001)(66556008)(53546011)(66476007)(31686004)(31696002)(36756003)(8676002)(5660300002)(6486002)(8936002)(6512007)(16526019)(186003)(966005)(2906002)(316002)(2616005)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB3865;H:MW3PR15MB3883.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +g5aJDvKpcWUD8Qyv+IyX9EHocsrnI9iJ57cTFMcHlnTF8hGdb3nNw+XvmjUZ/cNvyD6nUPSKoAP6gYM97RN+Vmll9dcYWrthyJN1IcnagNo1SRWZo8z/XgYpavg2WukxANkguLrdH6OtJeEevwessH/9XNZV5VHYWYaicWQbt0bw3I9lNX6gHEn/qZLGAc95CLwVBdeTxS/1q2OcK7FV2b6EDHurG4xOyrxKdwxl79TD9RoqUFzhSQN3ZwbYT5g+6l73Qokpl2i9ERhUBJspnpmm/2bOphiXALkbaBz/7dpAkvjZdf2UMHZTsqb5KCc0hz30CrI81Lc7MO7IL3fpsaNLP916Ager/80rCQ79vvUQAu1FZ4FKGQBQZOCY1MJB6lPWavOIJ1+H+BRGpVCffw1E+H1toxL3R6JYyuSa8R/jWEN3AUqTCy57jCyyfwLfO4LchFPS07wnPo2DGViCHjq6mK0lXzvPfPnyWQRQOEBCzcSk93pmTCo5cYuIEV5YT/Vx6nLmvSDOEJQSTMtPA==
X-MS-Exchange-AntiSpam-MessageData: 9YdYM+smhD+KUsf5K8gyqpUl1y9W6jUK4S45Ml8z/juw9XHpc6h6m5QDkmcxMZqK9jQvrce78O2mQ106nSAhCGWfi5n8TzE2od5MdZQmo5tPgl6dd+6LbJhGsfCe0EZc+9pLmQ49XsS5tstLmlnZtjk8IEyTrnC9kLHcuYnKAguT0jQyhpp6m3I3staaUgQF
X-MS-Exchange-CrossTenant-Network-Message-Id: 75396755-2c68-4052-868c-08d7ceec582f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 05:37:58.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IwrX42fRduICbJo88wGDLdGEFMp6slDB++A13m0VWQ8dS5Hckln/Y5ILkpDC4+m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3865
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_01:2020-03-21,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003230034
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/22/20 11:50 AM, Jason A. Donenfeld wrote:
> Hi,
> 
> Nicolas (CC'd) and I are working on a small utility that does some bpf
> things. What it actually does isn't important. But I did just clean up
> its use of libbpf by way of a Makefile:
> 
>> KERNEL_VERSION := 5.5.11
>> PKG_CONFIG ?= pkg-config
>>
>> all: linux-$(KERNEL_VERSION)/.prepared
>>      @$(MAKE) --no-print-directory netifexec
>>
>> linux-$(KERNEL_VERSION)/.prepared:
>>      curl https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$(KERNEL_VERSION).tar.xz | tar xJf -
>>      touch $@
>>
>> CFLAGS ?= -O3
>> CFLAGS += -Ilinux-$(KERNEL_VERSION)/tools/lib/bpf -Ilinux-$(KERNEL_VERSION)/tools/include -Ilinux-$(KERNEL_VERSION)/tools/include/uapi
>> CFLAGS += -DHAVE_LIBELF_MMAP_SUPPORT
>> CFLAGS += -MMD -MP
>> CFLAGS += -std=gnu99 -D_GNU_SOURCE
>> CFLAGS += -Wall
>> CFLAGS += $(shell $(PKG_CONFIG) --cflags libelf zlib)
>> LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib)
>>
>> netifexec: $(sort $(patsubst %.c,%.o,$(wildcard *.c linux-$(KERNEL_VERSION)/tools/lib/bpf/*.c)))
>>
>> clean:
>>      $(RM) netifexec *.o *.d linux-$(KERNEL_VERSION)/tools/lib/bpf/*.o linux-$(KERNEL_VERSION)/tools/lib/bpf/*.d
>>
>> mrproper: clean
>>      $(RM) -r linux-$(KERNEL_VERSION)
>>
>> .PHONY: all clean mrproper
> 
> Ignoring that piping curl to tar with no hash checking is unsafe, is
> this kind of embedding something you intended people would do to use
> this code externally? Or is there another distribution of this library
> from elsewhere that you'd recommend?

Jason, we have libbpf github mirror
    https://github.com/libbpf/libbpf
for the libbpf codes here.
Please take a look. The Makefile in the kernel tree contains some kernel
specific definitions/paths etc. The Makefile in the github is more 
suitable to be included/adapted for user space application.
You are welcome to contribute there (w.r.t. easy-to-use Makefile).

> 
> Jason
> 
