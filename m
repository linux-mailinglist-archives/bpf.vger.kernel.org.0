Return-Path: <bpf+bounces-464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCF870153F
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 10:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7271C20AA3
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B9510FE;
	Sat, 13 May 2023 08:24:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2336A10FA
	for <bpf@vger.kernel.org>; Sat, 13 May 2023 08:24:55 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CA82D78
	for <bpf@vger.kernel.org>; Sat, 13 May 2023 01:24:52 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34D8AiTx001751;
	Sat, 13 May 2023 08:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kF60cClX3aQopzH4txlWcAR4FzI0PWMFI7zjD3jgda4=;
 b=BI1hbItXqMtIXQw78cmgKBkwMv6hvGOFaQI7M1qyQOUg0mcq2KTBqn6AzZ0c+7LGfDT0
 i405CrZs4P40aHJ+op+BlYWpt9WKKSkHFXaiF5OuMW104c1LHv3rR/yMoUUbD4FpJ9Vz
 fnl7yTZqm5Ig9He9fdxqPUDrz8nXacKJGNJP4WSxpQRNPMiJV4iKOoOaANO0495L+dKm
 J211cNH52ZNtjAt54D3wefRYg86Ns9xW1K7iOX+j/pRv0XoEqtFBuJnWVFSUZZMDcIIn
 dtj7h3qrGRxtNDsW2z4TqDfA/9cLVgPLtHTC/Er58rYz2RUaVi6c+MtpASwdPl+fO3Ue Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qj5yuh5t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 May 2023 08:24:40 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34D8OeEm001902;
	Sat, 13 May 2023 08:24:40 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qj5yuh5sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 May 2023 08:24:40 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34D859mO011441;
	Sat, 13 May 2023 08:24:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qj265030a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 May 2023 08:24:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34D8OZnH44564784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 May 2023 08:24:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 421CE2004B;
	Sat, 13 May 2023 08:24:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95F4920040;
	Sat, 13 May 2023 08:24:34 +0000 (GMT)
Received: from [9.171.3.231] (unknown [9.171.3.231])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 May 2023 08:24:34 +0000 (GMT)
Message-ID: <75f39027fe1889cd69d01d439d558418cbd020a1.camel@linux.ibm.com>
Subject: Re: selftest sock_fields failed on s390x with latest llvm17
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Yonghong Song <yhs@meta.com>
Cc: bpf <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@meta.com>,
        Manu
 Bretelle <chantr4@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub
 Sitnicki <jakub@cloudflare.com>
Date: Sat, 13 May 2023 10:24:34 +0200
In-Reply-To: <8376a6d2-a3bc-4742-254f-a05605002c30@meta.com>
References: <e7f2c5e8-a50c-198d-8f95-388165f1e4fd@meta.com>
	 <daf235c37af3790f7dd7c1b2089617d49fad7b6e.camel@linux.ibm.com>
	 <47d0a6958657890d84dbd944782603175268b340.camel@linux.ibm.com>
	 <8376a6d2-a3bc-4742-254f-a05605002c30@meta.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kfwcO-8cBJZqFb9w3CAIUVxS3magDTRS
X-Proofpoint-ORIG-GUID: i1MlItE3M9x6i5JsacV_2V-wpj66HMr-
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
 definitions=2023-05-13_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305130074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-05-12 at 21:13 -0700, Yonghong Song wrote:
>=20
>=20
> On 5/12/23 7:40 AM, Ilya Leoshkevich wrote:
> > On Wed, 2023-05-03 at 21:46 +0200, Ilya Leoshkevich wrote:
> > > On Wed, 2023-05-03 at 12:35 -0700, Yonghong Song wrote:
> > > > Hi, Ilya,
> > > >=20
> > > > BPF CI ([1]) detected a s390x failure when bpf program is
> > > > compiled
> > > > with
> > > > latest llvm17 on bpf-next branch. To reproduce the issue, just
> > > > run
> > > > normal './test_progs -j'. The failure log looks like below:
> > > >=20
> > > > Notice: Success: 341/3015, Skipped: 29, Failed: 1
> > > > Error: #191 sock_fields
> > > > =C2=A0=C2=A0=C2=A0 Error: #191 sock_fields
> > > > =C2=A0=C2=A0=C2=A0 create_netns:PASS:create netns 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 create_netns:PASS:bring up lo 0 nsec
> > > > =C2=A0=C2=A0=C2=A0
> > > > serial_test_sock_fields:PASS:test_sock_fields__open_and_load 0
> > > > nsec
> > > > =C2=A0=C2=A0=20
> > > > serial_test_sock_fields:PASS:attach_cgroup(egress_read_sock_fie
> > > > lds)
> > > > 0
> > > > nsec
> > > > =C2=A0=C2=A0=20
> > > > serial_test_sock_fields:PASS:attach_cgroup(ingress_read_sock_fi
> > > > elds
> > > > )
> > > > 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 serial_test_sock_fields:PASS:attach_cgroup(read_=
sk_dst_port
> > > > 0
> > > > nsec
> > > > =C2=A0=C2=A0=C2=A0 test:PASS:getsockname(listen_fd) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 test:PASS:getsockname(cli_fd) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 test:PASS:accept(listen_fd) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_=
out_cnt_fd)
> > > > 0
> > > > nsec
> > > > =C2=A0=C2=A0=C2=A0
> > > > init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt10_fd) 0
> > > > nsec
> > > > =C2=A0=C2=A0=C2=A0 test:PASS:send(accept_fd) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 test:PASS:recv(cli_fd) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 test:PASS:send(accept_fd) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 test:PASS:recv(cli_fd) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 test:PASS:recv(accept_fd) for fin 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 test:PASS:recv(cli_fd) for fin 0 nsec
> > > > =C2=A0=C2=A0=C2=A0
> > > > check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cnt,
> > > > &accept_fd) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0
> > > > check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cnt,
> > > > &cli_fd) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 check_result:PASS:bpf_map_lookup_elem(linum_map_=
fd) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 check_result:PASS:bpf_map_lookup_elem(linum_map_=
fd) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 check_result:PASS:bpf_map_lookup_elem(linum_map_=
fd,
> > > > READ_SK_DST_PORT_IDX) 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 check_result:FAIL:failure in read_sk_dst_port on=
 line
> > > > unexpected
> > > > failure in read_sk_dst_port on line: actual 297 !=3D expected 0
> > > > =C2=A0=C2=A0=C2=A0 listen_sk: state:10 bound_dev_if:0 family:10 typ=
e:1
> > > > protocol:6
> > > > mark:0
> > > > priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
> > > > src_port:51966 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:0(::)
> > > > dst_port:0
> > > > =C2=A0=C2=A0=C2=A0 srv_sk: state:9 bound_dev_if:0 family:10 type:1 =
protocol:6
> > > > mark:0
> > > > priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
> > > > src_port:51966 dst_ip4:7f000006(127.0.0.6) dst_ip6:0:0:0:1(::1)
> > > > dst_port:38030
> > > > =C2=A0=C2=A0=C2=A0 cli_sk: state:5 bound_dev_if:0 family:10 type:1 =
protocol:6
> > > > mark:0
> > > > priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
> > > > src_port:38030 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:1(::1)
> > > > dst_port:51966
> > > > =C2=A0=C2=A0=C2=A0 listen_tp: snd_cwnd:10 srtt_us:0 rtt_min:4294967=
295
> > > > snd_ssthresh:2147483647 rcv_nxt:0 snd_nxt:0 snd:una:0
> > > > mss_cache:536
> > > > ecn_flags:0 rate_delivered:0 rate_interval_us:0 packets_out:0
> > > > retrans_out:0 total_retrans:0 segs_in:0 data_segs_in:0
> > > > segs_out:0
> > > > data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:0
> > > > bytes_acked:0
> > > > =C2=A0=C2=A0=C2=A0 srv_tp: snd_cwnd:10 srtt_us:3904 rtt_min:272
> > > > snd_ssthresh:2147483647
> > > > rcv_nxt:648617715 snd_nxt:4218065810 snd:una:4218065810
> > > > mss_cache:32768
> > > > ecn_flags:0 rate_delivered:1 rate_interval_us:272 packets_out:0
> > > > retrans_out:0 total_retrans:0 segs_in:5 data_segs_in:0
> > > > segs_out:3
> > > > data_segs_out:2 lost_out:0 sacked_out:0 bytes_received:1
> > > > bytes_acked:22
> > > > =C2=A0=C2=A0=C2=A0 cli_tp: snd_cwnd:10 srtt_us:6035 rtt_min:730
> > > > snd_ssthresh:2147483647
> > > > rcv_nxt:4218065811 snd_nxt:648617715 snd:una:648617715
> > > > mss_cache:32768
> > > > ecn_flags:0 rate_delivered:1 rate_interval_us:925 packets_out:0
> > > > retrans_out:0 total_retrans:0 segs_in:4 data_segs_in:2
> > > > segs_out:6
> > > > data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:23
> > > > bytes_acked:2
> > > > =C2=A0=C2=A0=C2=A0 check_result:PASS:listen_sk 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 check_result:PASS:srv_sk 0 nsec
> > > > =C2=A0=C2=A0=C2=A0 check_result:PASS:srv_tp 0 nsec
> > > >=20
> > > > If bpf program is compiled with llvm16, the test passed
> > > > according
> > > > to
> > > > a CI run.
> > > >=20
> > > > I don't have s390x environment to debug this. Could you help
> > > > debug
> > > > it?
> > > >=20
> > > > Thanks!
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 [1]
> > > > https://github.com/kernel-patches/vmtest/actions/runs/4866851496/jo=
bs/8679080985?pr=3D224#step:6:7645
> > >=20
> > >=20
> > > Hi,
> > >=20
> > > thank for letting me know.
> > > I will look into this.
> > >=20
> > > Best regards,
> > > Ilya
> >=20
> > In the meantime the issue was fixed by:
> >=20
> > commit 141be5c062ecf22bd287afffd310e8ac4711444a
> > Author: Shoaib Meenai <smeenai@fb.com>
> > Date:=C2=A0=C2=A0 Fri May 5 14:18:12 2023 -0700
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 Revert "Reland [Pipeline] Don't limit Argument=
Promotion to -
> > O3"
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 This reverts commit 6f29d1adf29820daae9ea7a01a=
e2588b67735b9e.
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 https://reviews.llvm.org/D149768=C2=A0 is caus=
ing size regressions
> > for -
> > Oz
> > =C2=A0=C2=A0=C2=A0=C2=A0 with FullLTO, and I'm reverting that one while=
 investigating.
> > This
> > =C2=A0=C2=A0=C2=A0=C2=A0 commit depends on that one, so it needs to be =
reverted as
> > well.
>=20
> The transformtion "Don't limit ArgumentPromotion to -O3" is
> temporarily=20
> reverted. But it could be reverted again once the issue is resolved.
> So it is a good idea to resolve the issue in the kernel.
>=20
> >=20
> > But looking at the codegen differences:
> >=20
> > $ diff -u <(sed -e s/[0-9]*://g pass.s) <(sed -e s/[0-9]*://g
> > fail.s)
> >=20
> > -pass.o:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file format elf64-bpf
> > +fail.o:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file format elf64-bpf
> >=20
> > -00000000000002c8 <sk_dst_port__load_half>
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 69 11 00 30 00 00 00 00 r1 =3D *(=
u16 *)(r1 + 48)
> > +00000000000002c0 <sk_dst_port__load_half>
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 54 10 00 00 00 00 ff ff w1 &=3D 6=
5535
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b4 00 00 00 00 00 00 0=
1 w0 =3D 1
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16 10 00 01 00 00 ca f=
e if w1 =3D=3D 51966 goto +1 <LBB6_2>
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b4 00 00 00 00 00 00 0=
0 w0 =3D 0
> >=20
> > This is what ArgumentPromotion is supposed to do, so that's okay so
> > far. However, further down below we have:
> >=20
> > =C2=A0 Disassembly of section cgroup_skb/egress:
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bf 16 00 00 00 00 00 00 r1 =3D r6
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 61 76 00 30 00 00 00 00 r7 =3D *(=
u32 *)(r6 + 48)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bc 17 00 00 00 00 00 00 w1 =3D w7
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 85 01 00 00 00 00 00 5=
3 call sk_dst_port__load_word
> >=20
> > ...
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bf 16 00 00 00 00 00 00 r1 =3D r6
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 74 70 00 00 00 00 00 10 w7 >>=3D =
16
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bc 17 00 00 00 00 00 00 w1 =3D w7
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 85 01 00 00 00 00 00 5=
7 call sk_dst_port__load_half
> >=20
> > so there is no 16-bit load anymore, instead, the result from the
> > earlier 32-bit load is reused. However, on BE these kinds of loads
> > for this particular field are not consistent at the moment - see
> > [1]
> > and the previous discussions.
> >=20
> > De-facto we have the following results:
> >=20
> > - int load: 0x0000cafe
> > - short load: 0xcafe
>=20
> So 'De-facto' means the above is the expected result.
>=20
> >=20
> > On a consistent BE we should have rather had:
> >=20
> > - int load: 0x0000cafe
> > - short load: 0
>=20
> What does 'consistent BE' mean here? Does it mean the expected
> result from the source code itself?

I should not have called the de-facto example "BE" at all: it's rather
"mixed endianness" or "weird endianness" or something along these
lines.

On "consistent BE" or simply "BE" properties like

*(uint32_t *)p =3D (*(uint16_t *)p << 16) | *(uint16_t *)(p + 2);

hold. This is currently not the case for bpf_sock.dst_port.

We compile with -mbig-endian, so we promise to the compiler that the
machine is big-endian, and the compiler expects the above to hold for
any p. Unfortunately when p points to bpf_sock.dst_port, this is not
the case.

The property above is important for the correctness of the load/store
tearing transformations. What we have here is not exactly tearing, but
is quite close.

> > Clang, of course, expects a consistent BE and optimizes around
> > that.
> >=20
> > This was a conscious tradeoff Jakub and I have agreed on in order
> > to
> > keep the quirky behavior from the past. Given what's happening with
> > Clang now, I wonder if it would be worth revisiting it in the name
> > of
> > consistency?
>=20
> If I understand correctly, I think the issue is
> =C2=A0=C2=A0=C2=A0=C2=A0 r7 =3D *(u32 *)(r6 + 48)
> =C2=A0=C2=A0=C2=A0=C2=A0 w7 >=3D 16
> =C2=A0=C2=A0=C2=A0=C2=A0 w1 =3D w7
>=20
> after verifier, it is changed to
> =C2=A0=C2=A0=C2=A0 r7 =3D *(u16 *)(r6 + <kernel offset>)
> =C2=A0=C2=A0=C2=A0 w7 >=3D 16
> =C2=A0=C2=A0=C2=A0 w1 =3D w7
>=20
> and the result after verifier rewrite is completely wrong.
> Is it right?

No, the verifier rewrite is correct.
The sk_dst_port__load_word() part of the test succeeds.

All these rewrites already work fine, they are correct and consistent.
It's really just bpf_sock.dst_port that is special.

> If this is the case, during verifier rewrite, if it is
> big endian, say the user intends to load 4 bytes (from uapi header)
> while the kernel field is 2 bytes, in such cases, kernel
> can still pretend to generate 4-byte load. For example,
> for the above example, the code after verification could be:
> =C2=A0=C2=A0=C2=A0 r7 =3D *(u16 *)(r6 + <kernel offset>)
> =C2=A0=C2=A0=C2=A0 r7 <=3D 16
> =C2=A0=C2=A0=C2=A0 w7 >=3D 16
> =C2=A0=C2=A0=C2=A0 w1 =3D w7
>=20
> Hopefully, we won't have many such cases. Does this work?

This would break the sk_dst_port__load_word() part of the test.



Above I asked whether we can resolve the inconsistency, but I thought
about it and I don't see a way of doing it without breaking the ABI,
which is at worst unacceptable, and at best a last resort measure.

What do you think about marking bpf_sock.dst_port volatile? volatile
should prevent tearing and similar optimizations, with which we have a
problem here.

We could also add a comment warning users not to cast away this
volatile due to the quirk we have. And then we should adjust the test
(making all casts volatile) to comply with this new warning.

> > [1]
> > https://lore.kernel.org/bpf/20220317113920.1068535-5-jakub@cloudflare.c=
om

