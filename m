Return-Path: <bpf+bounces-404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B67700A77
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAA3281B6A
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 14:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE36924130;
	Fri, 12 May 2023 14:40:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F4813
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 14:40:35 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFB41BF4
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 07:40:30 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CEC7tV013968;
	Fri, 12 May 2023 14:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OOZzFvojWmaBs/qCggJBYDhhO9I8EUh2I2ABDZB80sE=;
 b=OgiRWfBaIztdvNA2/sBBpymMS9IFvZRbRQ0xOAXgzfGw7O2G+/lT/wrTPm1woX3UxNkm
 tJ2+MQ+l0U2ddlgokAISSfPulugY/1l1HVxl4+lfJ6HoT2fpgbSiaiNITqI8aclEhCrX
 UBB2mZYD1JID9jLX9YlUeyilnxAEZNSV5wKIJVlMG8SU6MHT6CCM1rmPVdyR6/5XT0GC
 JbvPDA0dkV0g7Qx+o2Wd8ZDUZq9kiNDC0zrFfzxZjqbGTRn2NlKax3RjgYdexQgGX+4K
 02/Hp4LrEeO1MT8yN6z5zHkmKeqwzX30jSWn8KIdOONxxjmH5KRlNOIr1ITL79GFJoXV qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhnvtkb9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 May 2023 14:40:24 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CEZHeE000581;
	Fri, 12 May 2023 14:40:23 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qhnvtkb80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 May 2023 14:40:23 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34CE8Taa003948;
	Fri, 12 May 2023 14:40:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qf7s8hyk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 May 2023 14:40:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34CEeI0m27197946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 May 2023 14:40:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6113820063;
	Fri, 12 May 2023 14:40:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E44B520040;
	Fri, 12 May 2023 14:40:17 +0000 (GMT)
Received: from [9.179.21.203] (unknown [9.179.21.203])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 May 2023 14:40:17 +0000 (GMT)
Message-ID: <47d0a6958657890d84dbd944782603175268b340.camel@linux.ibm.com>
Subject: Re: selftest sock_fields failed on s390x with latest llvm17
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Yonghong Song <yhs@meta.com>
Cc: bpf <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@meta.com>,
        Manu
 Bretelle <chantr4@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub
 Sitnicki <jakub@cloudflare.com>
Date: Fri, 12 May 2023 16:40:17 +0200
In-Reply-To: <daf235c37af3790f7dd7c1b2089617d49fad7b6e.camel@linux.ibm.com>
References: <e7f2c5e8-a50c-198d-8f95-388165f1e4fd@meta.com>
	 <daf235c37af3790f7dd7c1b2089617d49fad7b6e.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lMlnErOW_6VUaOYf-BVc4s5ud7f8XIzk
X-Proofpoint-GUID: NHdIehYjvTu_m-yd6lR1358sulhZfZX8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-05-03 at 21:46 +0200, Ilya Leoshkevich wrote:
> On Wed, 2023-05-03 at 12:35 -0700, Yonghong Song wrote:
> > Hi, Ilya,
> >=20
> > BPF CI ([1]) detected a s390x failure when bpf program is compiled
> > with=20
> > latest llvm17 on bpf-next branch. To reproduce the issue, just run=20
> > normal './test_progs -j'. The failure log looks like below:
> >=20
> > Notice: Success: 341/3015, Skipped: 29, Failed: 1
> > Error: #191 sock_fields
> > =C2=A0=C2=A0 Error: #191 sock_fields
> > =C2=A0=C2=A0 create_netns:PASS:create netns 0 nsec
> > =C2=A0=C2=A0 create_netns:PASS:bring up lo 0 nsec
> > =C2=A0=C2=A0 serial_test_sock_fields:PASS:test_sock_fields__open_and_lo=
ad 0
> > nsec
> > =C2=A0=C2=A0
> > serial_test_sock_fields:PASS:attach_cgroup(egress_read_sock_fields)
> > 0
> > nsec
> > =C2=A0=C2=A0
> > serial_test_sock_fields:PASS:attach_cgroup(ingress_read_sock_fields
> > )=20
> > 0 nsec
> > =C2=A0=C2=A0 serial_test_sock_fields:PASS:attach_cgroup(read_sk_dst_por=
t 0
> > nsec
> > =C2=A0=C2=A0 test:PASS:getsockname(listen_fd) 0 nsec
> > =C2=A0=C2=A0 test:PASS:getsockname(cli_fd) 0 nsec
> > =C2=A0=C2=A0 test:PASS:accept(listen_fd) 0 nsec
> > =C2=A0=C2=A0 init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt_fd=
) 0
> > nsec
> > =C2=A0=C2=A0 init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt10_=
fd) 0
> > nsec
> > =C2=A0=C2=A0 test:PASS:send(accept_fd) 0 nsec
> > =C2=A0=C2=A0 test:PASS:recv(cli_fd) 0 nsec
> > =C2=A0=C2=A0 test:PASS:send(accept_fd) 0 nsec
> > =C2=A0=C2=A0 test:PASS:recv(cli_fd) 0 nsec
> > =C2=A0=C2=A0 test:PASS:recv(accept_fd) for fin 0 nsec
> > =C2=A0=C2=A0 test:PASS:recv(cli_fd) for fin 0 nsec
> > =C2=A0=C2=A0 check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_c=
nt,=20
> > &accept_fd) 0 nsec
> > =C2=A0=C2=A0 check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_c=
nt,=20
> > &cli_fd) 0 nsec
> > =C2=A0=C2=A0 check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0 nsec
> > =C2=A0=C2=A0 check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0 nsec
> > =C2=A0=C2=A0 check_result:PASS:bpf_map_lookup_elem(linum_map_fd,=20
> > READ_SK_DST_PORT_IDX) 0 nsec
> > =C2=A0=C2=A0 check_result:FAIL:failure in read_sk_dst_port on line unex=
pected
> > failure in read_sk_dst_port on line: actual 297 !=3D expected 0
> > =C2=A0=C2=A0 listen_sk: state:10 bound_dev_if:0 family:10 type:1 protoc=
ol:6
> > mark:0=20
> > priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)=20
> > src_port:51966 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:0(::) dst_port:0
> > =C2=A0=C2=A0 srv_sk: state:9 bound_dev_if:0 family:10 type:1 protocol:6
> > mark:0=20
> > priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)=20
> > src_port:51966 dst_ip4:7f000006(127.0.0.6) dst_ip6:0:0:0:1(::1)=20
> > dst_port:38030
> > =C2=A0=C2=A0 cli_sk: state:5 bound_dev_if:0 family:10 type:1 protocol:6
> > mark:0=20
> > priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)=20
> > src_port:38030 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:1(::1)
> > dst_port:51966
> > =C2=A0=C2=A0 listen_tp: snd_cwnd:10 srtt_us:0 rtt_min:4294967295=20
> > snd_ssthresh:2147483647 rcv_nxt:0 snd_nxt:0 snd:una:0 mss_cache:536
> > ecn_flags:0 rate_delivered:0 rate_interval_us:0 packets_out:0=20
> > retrans_out:0 total_retrans:0 segs_in:0 data_segs_in:0 segs_out:0=20
> > data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:0
> > bytes_acked:0
> > =C2=A0=C2=A0 srv_tp: snd_cwnd:10 srtt_us:3904 rtt_min:272
> > snd_ssthresh:2147483647=20
> > rcv_nxt:648617715 snd_nxt:4218065810 snd:una:4218065810
> > mss_cache:32768=20
> > ecn_flags:0 rate_delivered:1 rate_interval_us:272 packets_out:0=20
> > retrans_out:0 total_retrans:0 segs_in:5 data_segs_in:0 segs_out:3=20
> > data_segs_out:2 lost_out:0 sacked_out:0 bytes_received:1
> > bytes_acked:22
> > =C2=A0=C2=A0 cli_tp: snd_cwnd:10 srtt_us:6035 rtt_min:730
> > snd_ssthresh:2147483647=20
> > rcv_nxt:4218065811 snd_nxt:648617715 snd:una:648617715
> > mss_cache:32768=20
> > ecn_flags:0 rate_delivered:1 rate_interval_us:925 packets_out:0=20
> > retrans_out:0 total_retrans:0 segs_in:4 data_segs_in:2 segs_out:6=20
> > data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:23
> > bytes_acked:2
> > =C2=A0=C2=A0 check_result:PASS:listen_sk 0 nsec
> > =C2=A0=C2=A0 check_result:PASS:srv_sk 0 nsec
> > =C2=A0=C2=A0 check_result:PASS:srv_tp 0 nsec
> >=20
> > If bpf program is compiled with llvm16, the test passed according
> > to
> > a CI run.
> >=20
> > I don't have s390x environment to debug this. Could you help debug
> > it?
> >=20
> > Thanks!
> >=20
> > =C2=A0=C2=A0 [1]=20
> > https://github.com/kernel-patches/vmtest/actions/runs/4866851496/jobs/8=
679080985?pr=3D224#step:6:7645
>=20
>=20
> Hi,
>=20
> thank for letting me know.
> I will look into this.
>=20
> Best regards,
> Ilya

In the meantime the issue was fixed by:

commit 141be5c062ecf22bd287afffd310e8ac4711444a
Author: Shoaib Meenai <smeenai@fb.com>
Date:   Fri May 5 14:18:12 2023 -0700

    Revert "Reland [Pipeline] Don't limit ArgumentPromotion to -O3"
=20=20=20=20
    This reverts commit 6f29d1adf29820daae9ea7a01ae2588b67735b9e.
=20=20=20=20
    https://reviews.llvm.org/D149768 is causing size regressions for -
Oz
    with FullLTO, and I'm reverting that one while investigating. This
    commit depends on that one, so it needs to be reverted as well.

But looking at the codegen differences:

$ diff -u <(sed -e s/[0-9]*://g pass.s) <(sed -e s/[0-9]*://g fail.s)

-pass.o:        file format elf64-bpf
+fail.o:        file format elf64-bpf

-00000000000002c8 <sk_dst_port__load_half>
-       69 11 00 30 00 00 00 00 r1 =3D *(u16 *)(r1 + 48)
+00000000000002c0 <sk_dst_port__load_half>
+       54 10 00 00 00 00 ff ff w1 &=3D 65535
        b4 00 00 00 00 00 00 01 w0 =3D 1
        16 10 00 01 00 00 ca fe if w1 =3D=3D 51966 goto +1 <LBB6_2>
        b4 00 00 00 00 00 00 00 w0 =3D 0

This is what ArgumentPromotion is supposed to do, so that's okay so
far. However, further down below we have:

 Disassembly of section cgroup_skb/egress:

-       bf 16 00 00 00 00 00 00 r1 =3D r6
+       61 76 00 30 00 00 00 00 r7 =3D *(u32 *)(r6 + 48)
+       bc 17 00 00 00 00 00 00 w1 =3D w7
        85 01 00 00 00 00 00 53 call sk_dst_port__load_word

...

-       bf 16 00 00 00 00 00 00 r1 =3D r6
+       74 70 00 00 00 00 00 10 w7 >>=3D 16
+       bc 17 00 00 00 00 00 00 w1 =3D w7
        85 01 00 00 00 00 00 57 call sk_dst_port__load_half

so there is no 16-bit load anymore, instead, the result from the
earlier 32-bit load is reused. However, on BE these kinds of loads
for this particular field are not consistent at the moment - see [1]
and the previous discussions.

De-facto we have the following results:

- int load: 0x0000cafe
- short load: 0xcafe

On a consistent BE we should have rather had:

- int load: 0x0000cafe
- short load: 0

Clang, of course, expects a consistent BE and optimizes around that.

This was a conscious tradeoff Jakub and I have agreed on in order to
keep the quirky behavior from the past. Given what's happening with
Clang now, I wonder if it would be worth revisiting it in the name of
consistency?

[1]
https://lore.kernel.org/bpf/20220317113920.1068535-5-jakub@cloudflare.com

