Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D8B171097
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 06:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgB0FqB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 00:46:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59484 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgB0FqA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Feb 2020 00:46:00 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R5jg5E022747;
        Wed, 26 Feb 2020 21:45:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/bi57+EUBFqBO7c8qJ5++kh4Ksb2pmUhmXoEUZUkMns=;
 b=PbePxEzkxylq+3IbIpjgzWEBs6RTKMl6MMMgPt2fnDtfuXhA0Z9IH8SEwa+mOtvoMzsv
 myUeby/EPqEqAhMNcKjOVQBSbLsIBUtpz9yLY8vfAbrFRi1MzddOfqSbYd8CWFM3UVZ/
 4PTpQBpfxO8+GFj8wWuRCVXSmBfV+2r5J6s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ydcn2q68x-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 26 Feb 2020 21:45:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 26 Feb 2020 21:45:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfmdgWl8p5qkFQjD59DNfJHv+No0GGFxxZAluMnH+qci8Ew6XvFOdHu80GjTSXddi320clTL2e7i6cCQzHh9pIpklKOvwQiIV3KQ7m372C3NBXDhWSQbWetuvp9AjH/JNI5xFd2v+dPy4+wRcRCSnyyl2mYGh7rT//rW0idyarpsPjwlC6/1YrA2CtGvGlRKAPSoDwVUE/JfvEnTt95uZ7bqcAgVRtFHbIfqLPBhF7H54MrpRiCxVooamgqZY+Sxo3EFh4u/UHNn68VCz6s722Quwvjl83BtZvSmCE2iYT+25lqpRCpERr+uQed4vAsKzf/+Mc6VV3f7rAppkOG5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bi57+EUBFqBO7c8qJ5++kh4Ksb2pmUhmXoEUZUkMns=;
 b=Ml1Jbx8F1oi0UGtUyB7RvmE9Bzb43SY2qu9wQ0xb1alV/fHI4KWow90yQx5wHfM1L+8bjk2iQR/sy0f6p8nh+SZIQsPG9Y2hq5xI5En3ECLljsMquM20VhqJ26iaFwwci1uVvQUONUJ8xmUtq6QDZyVhImNZA2a9v5uG1clJlwxZK3XcIAZyq/zpIW4Oly+deIb8CBXBeXViZ0NmRY9bK4Nuk43tizrQuZ2AdRc1QBYxu96oNnTpegPyg8TlnrBXuVaItaIqqL1fJzBw/t5f1oHgQiHmndsAYp75h8FrAznGPBQV/JMeMWHA5x+0MRJrCJHos7GhRwUpVmiR+/+vig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bi57+EUBFqBO7c8qJ5++kh4Ksb2pmUhmXoEUZUkMns=;
 b=DXDMxgA1MFwmwnU1h/8guWqmGTBbDjgvds2yeu2LiCerAV37JRJ4d5cOd6qgt5hiekWRXpNGhWau05o4E1CDaaRR1uGAcfMaCbxvgvM/MqxKXvzoVNU3A4uCJD6lUptK1qQqW7rRTGvnihj6bbiXopAbmpOxGn+m5T1/ze168XM=
Received: from MW2PR1501MB2171.namprd15.prod.outlook.com
 (2603:10b6:302:13::27) by MW2PR1501MB2025.namprd15.prod.outlook.com
 (2603:10b6:302:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 05:45:29 +0000
Received: from MW2PR1501MB2171.namprd15.prod.outlook.com
 ([fe80::492d:3e00:17dc:6b30]) by MW2PR1501MB2171.namprd15.prod.outlook.com
 ([fe80::492d:3e00:17dc:6b30%7]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 05:45:29 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrey Ignatov <rdna@fb.com>
CC:     bpf <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Omar Sandoval <osandov@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
Thread-Topic: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
Thread-Index: AQHV7RZJB1TQjJS/Nk+NHCtDZN+VuqguiA4A
Date:   Thu, 27 Feb 2020 05:45:29 +0000
Message-ID: <CE954665-BFCB-4E83-B20F-AECD12E180D2@fb.com>
References: <20200227023253.3445221-1-rdna@fb.com>
In-Reply-To: <20200227023253.3445221-1-rdna@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.60.0.2.5)
x-originating-ip: [2620:10d:c090:400::5:5282]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7ced944-4f64-42b8-da9d-08d7bb4840cb
x-ms-traffictypediagnostic: MW2PR1501MB2025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR1501MB202500DE6616AA74FCAEA6BDB3EB0@MW2PR1501MB2025.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(6636002)(6862004)(33656002)(71200400001)(4326008)(186003)(86362001)(5660300002)(2906002)(36756003)(8936002)(316002)(37006003)(81156014)(54906003)(81166006)(8676002)(966005)(76116006)(478600001)(66946007)(6506007)(2616005)(66446008)(6486002)(66556008)(66476007)(6512007)(53546011)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR1501MB2025;H:MW2PR1501MB2171.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JooYc5UNYpkMoU+h+iTFJJ59GjLw70XkMJ+wxc8qbGlyCLRBlPYclYq/QNlrzN57IoP/IY2TxL6V55rlCwNW5msu1lV+Iokvgh1fOHhs1AwskdcN0TfJMFJlLGgvKVzL6RT3zk0GxV4XWV/hu1WCCzygDogiHlO5eAWtOdQ5mtwPzaNf6H6CwvKlj+bwfCXXFh6YrOuk/nNeW+8xSHzEXI0d/tDXiUmIk94pRthAolqhwbxwSobv8kxayAJtGJ9JgzYnzqn4UH11ZZHgOu5D6gHOOYnEwzrhRKciFrpS/iKKzyk4nf1+ej1nZYXXtukK8skNyDEGvv5MppCxTrkLGXWWrL6MQPu6HhZKBq6EgImxssGRrqYnIzpKVUnzUDlGoMGOSKte5zkl9sMqF1MTa9lzJM+34VEWWpW39WVqIJcQADTA3qnyzL4GOHnVpdBnhimZHVDsSyMrVQQ7d3rMQCq0KKqZzow/TKCMosKWkGp5R9Ppz0W6OZM6DrZYrPIrJpcg+O36nu2ERVY+V/Sp0hjWmH7yQCmIYkEWuJNrrLz+z0A8Sy7F5T3/oQbz+soqWgSMmSNCbWqCeaMu/bVXuAagq0crsWeAoGHYNsOADlVqIUwOE3F4SuhHae2mXdp
x-ms-exchange-antispam-messagedata: 2nBumSfSfqUPy6dSYC7PKYOG/0y7o2TMRp8Q+y65tF5gTe0EZevlH4rluTPJPtYR0XwLWqKh2qd7fH8/Er7KTIJIC5q6r3t4YN/u1DXV1boL6iyRdwl5klcjGpMoqVwGvAH2gNM29nAqbtx27cXVB7kXuZClnb6nF2peZ5LgpP8YU92TcG6Bd5Qb3VSvOChh
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3542AED1848B240B649DB6B9E9BBBB1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ced944-4f64-42b8-da9d-08d7bb4840cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 05:45:29.0478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCGzCzpQLHjrLmpp5kxqEyBpswrQ16HJhgCYbgdWCgXsmomwjQL3uQEMgPXYrGW9UbD0Bo49ig3x6tfeHjZgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2025
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_01:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=486 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270043
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Feb 26, 2020, at 6:32 PM, Andrey Ignatov <rdna@fb.com> wrote:
>=20
> drgn is a debugger that reads kernel memory and uses DWARF to get types
> and symbols. See [1], [2] and [3] for more details on drgn.
>=20
> Since drgn operates on kernel memory it has access to kernel internals
> that user space doesn't. It allows to get extended info about various
> kernel data structures.
>=20
> Introduce bpf.py drgn script to list BPF programs and maps and their
> properties unavailable to user space via kernel API.
>=20
> The main use-case bpf.py covers is to show BPF programs attached to
> other BPF programs via freplace/fentry/fexit mechanisms introduced
> recently. There is no user-space API to get this info and e.g. bpftool
> can only show all BPF programs but can't show if program A replaces a
> function in program B.

IIUC, bpftool misses features to show fireplace/fentry/fexit relations?=20
I think we should enable that in bpftool.=20

>=20
> Example:
>=20
>  % sudo tools/bpf/bpf.py p | grep test_pkt_access
>     650: BPF_PROG_TYPE_SCHED_CLS          test_pkt_access
>     654: BPF_PROG_TYPE_TRACING            test_main                      =
  linked:[650->25: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access()]
>     655: BPF_PROG_TYPE_TRACING            test_subprog1                  =
  linked:[650->29: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog=
1()]
>     656: BPF_PROG_TYPE_TRACING            test_subprog2                  =
  linked:[650->31: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog=
2()]
>     657: BPF_PROG_TYPE_TRACING            test_subprog3                  =
  linked:[650->21: BPF_TRAMP_FEXIT test_pkt_access->test_pkt_access_subprog=
3()]
>     658: BPF_PROG_TYPE_EXT                new_get_skb_len                =
  linked:[650->16: BPF_TRAMP_REPLACE test_pkt_access->get_skb_len()]
>     659: BPF_PROG_TYPE_EXT                new_get_skb_ifindex            =
  linked:[650->23: BPF_TRAMP_REPLACE test_pkt_access->get_skb_ifindex()]
>     660: BPF_PROG_TYPE_EXT                new_get_constant               =
  linked:[650->19: BPF_TRAMP_REPLACE test_pkt_access->get_constant()]
>=20
> It can be seen that there is a program test_pkt_access, id 650 and there
> are multiple other tracing and ext programs attached to functions in
> test_pkt_access.
>=20
> For example the line:
>=20
>     658: BPF_PROG_TYPE_EXT                new_get_skb_len                =
  linked:[650->16: BPF_TRAMP_REPLACE test_pkt_access->get_skb_len()]
>=20
> means that BPF program new_get_skb_len, id 658, type BPF_PROG_TYPE_EXT
> replaces (BPF_TRAMP_REPLACE) function get_skb_len() that has BTF id 16
> in BPF program test_pkt_access, prog id 650.
>=20
> Just very simple output is supported now but it can be extended in the
> future if needed.
>=20
> The script is extendable and currently implements two subcommands:
> * prog (alias: p) to list all BPF programs;
> * map (alias: m) to list all BPF maps;
>=20
> Developer can simply tweak the script to print interesting pieces of prog=
rams
> or maps.
>=20
> The name bpf.py is not super authentic. I'm open to better options.

Maybe call it bpftool.py? Or bpfshow.py?

>=20
> The script can be sent to drgn repo where it's easier to maintain its
> "drgn-ness", but in kernel tree it should be easier to maintain BPF
> functionality itself what can be more important in this case.
>=20
> The script depends on drgn revision [4] where BPF helpers were added.
>=20
> More examples of output:
>=20
>  % sudo tools/bpf/bpf.py p | shuf -n 3
>      81: BPF_PROG_TYPE_CGROUP_SOCK_ADDR   tw_ipt_bind
>      94: BPF_PROG_TYPE_CGROUP_SOCK_ADDR   tw_ipt_bind
>      43: BPF_PROG_TYPE_KPROBE             kprobe__tcp_reno_cong_avoid
>=20
>  % sudo tools/bpf/bpf.py m | shuf -n 3
>     213: BPF_MAP_TYPE_HASH                errors
>      30: BPF_MAP_TYPE_ARRAY               sslwall_setting
>      41: BPF_MAP_TYPE_LRU_HASH            flow_to_snd
>=20
> Help:
>=20
>  % sudo tools/bpf/bpf.py
>  usage: bpf.py [-h] {prog,p,map,m} ...
>=20
>  drgn script to list BPF programs or maps and their properties
>  unavailable via kernel API.
>=20
>  See https://github.com/osandov/drgn/ for more details on drgn.
>=20
>  optional arguments:
>    -h, --help      show this help message and exit
>=20
>  subcommands:
>    {prog,p,map,m}
>      prog (p)      list BPF programs
>      map (m)       list BPF maps
>=20
> [1] https://github.com/osandov/drgn/
> [2] https://drgn.readthedocs.io/en/latest/index.html
> [3] https://lwn.net/Articles/789641/
> [4] https://github.com/osandov/drgn/commit/c8ef841768032e36581d45648e42fc=
2a5489d8f2
>=20
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

The code looks good to me (with name TBD).=20

Acked-by: Song Liu <songliubraving@fb.com>

