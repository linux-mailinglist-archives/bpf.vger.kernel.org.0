Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D9E213F2D
	for <lists+bpf@lfdr.de>; Fri,  3 Jul 2020 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgGCSJU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jul 2020 14:09:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47978 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgGCSJU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 3 Jul 2020 14:09:20 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 063I5aOB009108;
        Fri, 3 Jul 2020 11:09:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=n9WB7tVrtWeow4IAePXy0glMrxzyS4QURWJDfAoAUWI=;
 b=SZRmijbglf1zY9KRIBn9cvqT22qMrGNxxI/u/j4v6EnZLIKHb69BWwf7Gm8lbzdiod4i
 jXVmQUks2Tr/1pKw014Z6zQm6t7cYYb/PKA03O3l4hT9FJ2Y6xkFelxmMS5ycZU7bk6X
 hcKxR2gVZugljLD/shYND8sYDId1v+sxlF8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 321k40ndc8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Jul 2020 11:09:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 3 Jul 2020 11:09:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU5lS9RLW3uth023RXhLZOfK8oS3YlYPQw8/ycvEzFKGFj0t1r9E4WEAd6jVxcKvnnIMkY9sxbURieb85SnbP7DfP8gke5Iv7YcFwV7C3gSpP6fme02bG4MdnhEnr6RF7Cc7c13HUL5Uz0qcUG6bTQ/Z4KKQN8Yu71ctxDtPT1Vs+FQeh0Xy8SB6YkblPbL3bOMyjFUfPB7DjYOb5NMv9HB68MVTMoOopyfuGEKn4dgqj5EUee05oaZ9FSarkrZ5xCYriL+yCecGPwtP1/P5zm/blg8/boqKBpRmVLnojEi4n9j+xWCmy1C5oRSJ/7QGV08eREzQffM+/RAxrU7NSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9WB7tVrtWeow4IAePXy0glMrxzyS4QURWJDfAoAUWI=;
 b=JOhiDZWgNR4Ie+tR9yibIdzx9f3xH+omWUDaX2D2PCCszDoxYSCepphqSdfCC4hVDlGShMM5ucFIkWD9AzIDfdOWX6bDztTTlM6iLwHiokt2jM5xhGHz66TnWe0oPtVi5m+8qwrP7lloeK1625d8Fn7d5cjmF+8eUu7FUwgZCmP1OQu8I50xm3DJCEFQwoEgqcBs3200K3hV8dMOus1mmDyqo2qk+90/3XZryfs/n4UdE/q16MaRn7uc61x2BUupjmcMvkrPn2R0LgKvQcLk/1dWFUj76kI5n1K3quaobl+qUyJXjh9z7+q/D02GMSFAVsd4YMLRgFUMY0PD6j6r0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9WB7tVrtWeow4IAePXy0glMrxzyS4QURWJDfAoAUWI=;
 b=EPZ7++av5yc92V0Jyhgid8OJmtWMJT/xcLFRm4FkiiDsgoRZS8tgz2V2SdDuOYeD8/HEVukXzJINKdAwMsxQdnJRD3WfzWGP90Mq3+yAdJfKXK2+iQrSA6QcE3UyuhCFi5PsB0DP4q4Gww2uSnH4VZIAx5UqAuPwYD9Uqig/yyU=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2821.namprd15.prod.outlook.com (2603:10b6:a03:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 18:09:01 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::543:b185:ef4a:7e8%5]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 18:09:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
CC:     BPF-dev-list <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: Build errors in tools/testing/selftests/bpf/ at 046cc3dd9a25
Thread-Topic: Build errors in tools/testing/selftests/bpf/ at 046cc3dd9a25
Thread-Index: AQHWUUewDhgYb+5cV0ey43ZVJH+Rnaj2J3+A
Date:   Fri, 3 Jul 2020 18:09:01 +0000
Message-ID: <48A2F3E2-6926-47BA-B13D-6E90EFBA7919@fb.com>
References: <20200703163837.0611d26a@carbon>
In-Reply-To: <20200703163837.0611d26a@carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:2955]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e58f22ec-3924-48c5-23de-08d81f7c2a35
x-ms-traffictypediagnostic: BYAPR15MB2821:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2821D2DE38AA64870D9B13F5B36A0@BYAPR15MB2821.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELUblK+yWjDjpFGdAsHuR+3dqirmYxevwnsBB62oIX7XpQrTWUfOhwFA5f6Me4Tb6VbeH2zDoaoBrnvk1Ed8NU87Q0ZCYZ7FuTG/sXzpVusyJVdWAenEzjrUMAZuuw6UlemhqUiRi5sDbTKwyeNx7Jah1ybfQIlLQ4m+Z3r2JB2R+cWDHTOZlSxq35AizCgxciLRPlAZR1JUipnx1z2P/fu0vWNihc0NI5SKBky2rCllKxVF++j96KOTl+J5dnm4EqMuRlA7/HUiim5pT6QNDDobvF7TBoVC+cniW0Ek5qjDLAic4Vjmpe+HlgGlFqZ2Wdjclwo9X0Nd/GB7ykWQW1SQuvRPhnrEmkvITKpTd5lZnjGViKNnM2VfObjakEGTR+H+96F2O14gbNdzu7vZVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(478600001)(8936002)(6486002)(966005)(6916009)(2906002)(8676002)(71200400001)(83380400001)(5660300002)(66946007)(45080400002)(2616005)(66476007)(186003)(66556008)(64756008)(66446008)(76116006)(316002)(54906003)(33656002)(86362001)(6506007)(53546011)(36756003)(4326008)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6u1idfZz8xE3UXhyl912NneNdZChutQ737JT+AkLxXkR1hlajSrLkU/3Ks2VLZxItskpc5KaoXZltC5EhNthyVn1whKhIjc2XCoUzjWzQiQVearE/S0eev7s5+1vFQHSMsw0S7TqQyO/u1hF/NFv/BqLP/KCTT8dkh2PddctKk0YsPZ8TLbMtRoCtgl6dFwqTW/gdXNGdRbCGRaJar3rdmWhTfrRUr6L4dM8vAX5PNu5hjI3Tw/IrfUWfhcnlfNahpnClLT+Z+pAy39deqwOoHoSYiY1DLbB5flhJipNdYuJgtfHjQbFhfjJ1B0iOz3QQ6lrA3mp+LN6IV8F7qYZjzoR84iiW30rkmXwmwSNgJCPB/psZIvK6U1eGtTynFjigs81aJ+xq0EI87oxtONEUWxgHbmMu+uUxKWf4LREbHMyHmkmMwZ0HUnyCuhi1+MCZSwZ91TgnbOnV1Kv5H0YS/qcWBzAAy4UBzhY2ajs0NwPUKSw9WISUXx65MyorIRd8pwo10dK8m1qDCwQw3vIhA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F5A6ED0FA3FB5242A36E0569BA503AC0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58f22ec-3924-48c5-23de-08d81f7c2a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 18:09:01.6337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rE636F0PKelGHx3aNlYRfjGGRkXMfdO5f4AR2bE/T5lnbwjApKyPr00aOttW38qfyo0I3RmjHAnlvxLsZDHQQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2821
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-03_14:2020-07-02,2020-07-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 clxscore=1011 cotscore=-2147483648 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007030122
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jesper,

> On Jul 3, 2020, at 7:38 AM, Jesper Dangaard Brouer <brouer@redhat.com> wr=
ote:
>=20
> Hi Song,
>=20
> I' getting this compile error in tools/testing/selftests/bpf/ on
> bpf-next git tree with HEAD 046cc3dd9a25 ("bpf: Fix build without
> CONFIG_STACKTRACE"):
>=20
> $ pwd
> /home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf
> $ make=20
> Warning: Kernel ABI header at 'tools/include/uapi/linux/netlink.h' differ=
s from latest version at 'include/uapi/linux/netlink.h'
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differ=
s from latest version at 'include/uapi/linux/if_link.h'
>   INSTALL  headers
>   GEN-SKEL [test_progs] bpf_iter_task_stack.skel.h
> libbpf: invalid relo for 'entries' in special section 0xfff2; forgot to i=
nitialize global var?..
> Error: failed to open BPF object file: 0
> make: *** [Makefile:372: /home/jbrouer/git/kernel/bpf-next/tools/testing/=
selftests/bpf/bpf_iter_task_stack.skel.h] Error 255
> make: *** Deleting file '/home/jbrouer/git/kernel/bpf-next/tools/testing/=
selftests/bpf/bpf_iter_task_stack.skel.h'

Thanks for the report! Looks like there are some more checks in libbpf.=20
Sending a fix...

Song

>=20
>=20
> If I revert c7568114bc56 ("selftests/bpf: Add bpf_iter test with
> bpf_get_task_stack()") (Author: Song Liu) then it compiles again.
>=20
> --=20
> Best regards,
>  Jesper Dangaard Brouer
>  MSc.CS, Principal Kernel Engineer at Red Hat
>  LinkedIn: https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__www.link=
edin.com_in_brouer&d=3DDwICAg&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy=
0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=3De_FAl1at-_JkxvdBgN-A4MxYgcG7GCcILfqCfG2fw=
Dg&s=3DAXys933GuyB-Gq6PGMRSjZsmJZt-tiDVvakHcNyaKAY&e=3D=20
>=20
> More details:
>=20
> $ clang --version
> clang version 10.0.0 (https://github.com/llvm/llvm-project.git 90c78073f7=
3eac58f4f8b4772a896dc8aac023bc)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/local/bin
>=20
> llc --version
> LLVM (https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__llvm.org_&d=
=3DDwICAg&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DdR8692q0_uaizy0jkrBJQM5k2hfm4CiFxY=
T8KaysFrg&m=3De_FAl1at-_JkxvdBgN-A4MxYgcG7GCcILfqCfG2fwDg&s=3DKCTx5PCpgbta-=
I0hnVe-MrEYLtM7WgACk_euEYjODLw&e=3D ):
>  LLVM version 10.0.0git
>  Optimized build.
>  Default target: x86_64-unknown-linux-gnu
>  Host CPU: ivybridge
>=20
>  Registered Targets:
>    bpf    - BPF (host endian)
>    bpfeb  - BPF (big endian)
>    bpfel  - BPF (little endian)
>    x86    - 32-bit X86: Pentium-Pro and above
>    x86-64 - 64-bit X86: EM64T and AMD64
>=20
>=20
> make V=3D1
> (clang  -g -D__TARGET_ARCH_x86 -mlittle-endian -I/home/jbrouer/git/kernel=
/bpf-next/tools/testing/selftests/bpf/tools/include -I/home/jbrouer/git/ker=
nel/bpf-next/tools/testing/selftests/bpf -I/home/jbrouer/git/kernel/bpf-nex=
t/tools/include/uapi -I/home/jbrouer/git/kernel/bpf-next/tools/testing/self=
tests/usr/include -idirafter /usr/local/include -idirafter /usr/local/stow/=
llvm-10.0.0-rc2/lib/clang/10.0.0/include -idirafter /usr/include -Wno-compa=
re-distinct-pointer-types -O2 -target bpf -emit-llvm -c progs/bpf_iter_task=
_stack.c -o - || echo "BPF obj compilation failed") | llc -mattr=3Ddwarfris=
 -march=3Dbpf -mcpu=3Dv3  -mattr=3D+alu32 -filetype=3Dobj -o /home/jbrouer/=
git/kernel/bpf-next/tools/testing/selftests/bpf/bpf_iter_task_stack.o
>=20
> /home/jbrouer/git/kernel/bpf-next/tools/testing/selftests/bpf/tools/sbin/=
bpftool gen skeleton /home/jbrouer/git/kernel/bpf-next/tools/testing/selfte=
sts/bpf/bpf_iter_task_stack.o > /home/jbrouer/git/kernel/bpf-next/tools/tes=
ting/selftests/bpf/bpf_iter_task_stack.skel.h
> libbpf: invalid relo for 'entries' in special section 0xfff2; forgot to i=
nitialize global var?..
> Error: failed to open BPF object file: 0
> make: *** [Makefile:372: /home/jbrouer/git/kernel/bpf-next/tools/testing/=
selftests/bpf/bpf_iter_task_stack.skel.h] Error 255
> make: *** Deleting file '/home/jbrouer/git/kernel/bpf-next/tools/testing/=
selftests/bpf/bpf_iter_task_stack.skel.h'
>=20

