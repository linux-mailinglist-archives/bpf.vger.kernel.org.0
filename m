Return-Path: <bpf+bounces-619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412D47049F0
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 11:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED43928137A
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DAA18C24;
	Tue, 16 May 2023 09:59:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5C2C726
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 09:59:12 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24CD199C
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 02:59:01 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G99UdU020354;
	Tue, 16 May 2023 09:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=L02sqcUUVjOBIlT46vXNlwRWCs3GipW0KIfAHmfgPqw=;
 b=BbbEMeUUHHEvvwJJdlF4m4JqgUBZDWF3eTL/bNdqA6x7jVb85OhDcIeDwaY4/cUx8rL5
 QsPizQ2I1b5GrWpcZyzNkzVqNaJaRU5ZzCq/yfIGaqBTTkVffjw7PmeimBdvb6eARJ8v
 06tXwvu0lM1gLQcpyupIfGBH0NNU+8QyrqvzlGYznUoWCX4IaW8C6pOA/OIWg1ClGxOw
 MD5tKURZkl8XPuHwmoAxPNwu15SI3Z+EvQG4I9sl5f+/MkIiMohvyLBcpcXU+ovueW4A
 whl0VFxCOYBgdnk947AFpqTT7w3Yvmv5a9ll5Vlxn/Jn0IDj+ymyUBGcD1TZfpourC0o 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm42v57j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 May 2023 09:16:48 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34G9ANqN025230;
	Tue, 16 May 2023 09:16:47 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm42v57ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 May 2023 09:16:47 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G67uIT005223;
	Tue, 16 May 2023 09:16:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qj264sh2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 May 2023 09:16:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34G9Ghxc27919068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 May 2023 09:16:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED43720043;
	Tue, 16 May 2023 09:16:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6908E20040;
	Tue, 16 May 2023 09:16:42 +0000 (GMT)
Received: from [9.171.74.253] (unknown [9.171.74.253])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 May 2023 09:16:42 +0000 (GMT)
Message-ID: <4c1c070f43ac53bf22aa71fb205ee83d45403143.camel@linux.ibm.com>
Subject: Re: selftest sock_fields failed on s390x with latest llvm17
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Yonghong Song <yhs@meta.com>
Cc: bpf <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@meta.com>,
        Manu
 Bretelle <chantr4@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub
 Sitnicki <jakub@cloudflare.com>
Date: Tue, 16 May 2023 11:16:42 +0200
In-Reply-To: <5a57547e-6865-1026-60db-bb6b2ca70e34@meta.com>
References: <e7f2c5e8-a50c-198d-8f95-388165f1e4fd@meta.com>
	 <daf235c37af3790f7dd7c1b2089617d49fad7b6e.camel@linux.ibm.com>
	 <47d0a6958657890d84dbd944782603175268b340.camel@linux.ibm.com>
	 <8376a6d2-a3bc-4742-254f-a05605002c30@meta.com>
	 <75f39027fe1889cd69d01d439d558418cbd020a1.camel@linux.ibm.com>
	 <d275bd5e-e468-c590-9a10-8230a9ad7daa@meta.com>
	 <35094b7c6fbe9843638a3695d56a92e42f3cfe4c.camel@linux.ibm.com>
	 <5a57547e-6865-1026-60db-bb6b2ca70e34@meta.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8fd_wiRO762mfqfnEmzSy-mdX6JNhL5B
X-Proofpoint-ORIG-GUID: lRbdNlU2OeDgKBhaLl-7LUBr4poYNGF1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-05-15 at 08:27 -0700, Yonghong Song wrote:
>=20
>=20
> On 5/15/23 12:55 AM, Ilya Leoshkevich wrote:
> > On Sun, 2023-05-14 at 09:58 -0700, Yonghong Song wrote:
> > >=20
> > >=20
> > > On 5/13/23 1:24 AM, Ilya Leoshkevich wrote:
> > > > On Fri, 2023-05-12 at 21:13 -0700, Yonghong Song wrote:
> > > > >=20
> > > > >=20
> > > > > On 5/12/23 7:40 AM, Ilya Leoshkevich wrote:
> > > > > > On Wed, 2023-05-03 at 21:46 +0200, Ilya Leoshkevich wrote:
> > > > > > > On Wed, 2023-05-03 at 12:35 -0700, Yonghong Song wrote:
> > > > > > > > Hi, Ilya,
> > > > > > > >=20
> > > > > > > > BPF CI ([1]) detected a s390x failure when bpf program
> > > > > > > > is
> > > > > > > > compiled
> > > > > > > > with
> > > > > > > > latest llvm17 on bpf-next branch. To reproduce the
> > > > > > > > issue,
> > > > > > > > just
> > > > > > > > run
> > > > > > > > normal './test_progs -j'. The failure log looks like
> > > > > > > > below:
> > > > > > > >=20
> > > > > > > > Notice: Success: 341/3015, Skipped: 29, Failed: 1
> > > > > > > > Error: #191 sock_fields
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error: #191 sock_fields
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 create_netns:PASS:create net=
ns 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 create_netns:PASS:bring up l=
o 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > serial_test_sock_fields:PASS:test_sock_fields__open_and
> > > > > > > > _loa
> > > > > > > > d 0
> > > > > > > > nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > serial_test_sock_fields:PASS:attach_cgroup(egress_read_
> > > > > > > > sock
> > > > > > > > _fie
> > > > > > > > lds)
> > > > > > > > 0
> > > > > > > > nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > serial_test_sock_fields:PASS:attach_cgroup(ingress_read
> > > > > > > > _soc
> > > > > > > > k_fi
> > > > > > > > elds
> > > > > > > > )
> > > > > > > > 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > serial_test_sock_fields:PASS:attach_cgroup(read_sk_dst_
> > > > > > > > port
> > > > > > > > 0
> > > > > > > > nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test:PASS:getsockname(listen=
_fd) 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test:PASS:getsockname(cli_fd=
) 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test:PASS:accept(listen_fd) =
0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt
> > > > > > > > _fd)
> > > > > > > > 0
> > > > > > > > nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt
> > > > > > > > 10_f
> > > > > > > > d) 0
> > > > > > > > nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test:PASS:send(accept_fd) 0 =
nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test:PASS:recv(cli_fd) 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test:PASS:send(accept_fd) 0 =
nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test:PASS:recv(cli_fd) 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test:PASS:recv(accept_fd) fo=
r fin 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test:PASS:recv(cli_fd) for f=
in 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_ou
> > > > > > > > t_cn
> > > > > > > > t,
> > > > > > > > &accept_fd) 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_ou
> > > > > > > > t_cn
> > > > > > > > t,
> > > > > > > > &cli_fd) 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0
> > > > > > > > nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0
> > > > > > > > nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > check_result:PASS:bpf_map_lookup_elem(linum_map_fd,
> > > > > > > > READ_SK_DST_PORT_IDX) 0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_result:FAIL:failure in=
 read_sk_dst_port on
> > > > > > > > line
> > > > > > > > unexpected
> > > > > > > > failure in read_sk_dst_port on line: actual 297 !=3D
> > > > > > > > expected
> > > > > > > > 0
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 listen_sk: state:10 bound_de=
v_if:0 family:10
> > > > > > > > type:1
> > > > > > > > protocol:6
> > > > > > > > mark:0
> > > > > > > > priority:0 src_ip4:7f000006(127.0.0.6)
> > > > > > > > src_ip6:0:0:0:1(::1)
> > > > > > > > src_port:51966 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:0(::)
> > > > > > > > dst_port:0
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 srv_sk: state:9 bound_dev_if=
:0 family:10 type:1
> > > > > > > > protocol:6
> > > > > > > > mark:0
> > > > > > > > priority:0 src_ip4:7f000006(127.0.0.6)
> > > > > > > > src_ip6:0:0:0:1(::1)
> > > > > > > > src_port:51966 dst_ip4:7f000006(127.0.0.6)
> > > > > > > > dst_ip6:0:0:0:1(::1)
> > > > > > > > dst_port:38030
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cli_sk: state:5 bound_dev_if=
:0 family:10 type:1
> > > > > > > > protocol:6
> > > > > > > > mark:0
> > > > > > > > priority:0 src_ip4:7f000006(127.0.0.6)
> > > > > > > > src_ip6:0:0:0:1(::1)
> > > > > > > > src_port:38030 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:1(::1)
> > > > > > > > dst_port:51966
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 listen_tp: snd_cwnd:10 srtt_=
us:0
> > > > > > > > rtt_min:4294967295
> > > > > > > > snd_ssthresh:2147483647 rcv_nxt:0 snd_nxt:0 snd:una:0
> > > > > > > > mss_cache:536
> > > > > > > > ecn_flags:0 rate_delivered:0 rate_interval_us:0
> > > > > > > > packets_out:0
> > > > > > > > retrans_out:0 total_retrans:0 segs_in:0 data_segs_in:0
> > > > > > > > segs_out:0
> > > > > > > > data_segs_out:0 lost_out:0 sacked_out:0
> > > > > > > > bytes_received:0
> > > > > > > > bytes_acked:0
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 srv_tp: snd_cwnd:10 srtt_us:=
3904 rtt_min:272
> > > > > > > > snd_ssthresh:2147483647
> > > > > > > > rcv_nxt:648617715 snd_nxt:4218065810 snd:una:4218065810
> > > > > > > > mss_cache:32768
> > > > > > > > ecn_flags:0 rate_delivered:1 rate_interval_us:272
> > > > > > > > packets_out:0
> > > > > > > > retrans_out:0 total_retrans:0 segs_in:5 data_segs_in:0
> > > > > > > > segs_out:3
> > > > > > > > data_segs_out:2 lost_out:0 sacked_out:0
> > > > > > > > bytes_received:1
> > > > > > > > bytes_acked:22
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cli_tp: snd_cwnd:10 srtt_us:=
6035 rtt_min:730
> > > > > > > > snd_ssthresh:2147483647
> > > > > > > > rcv_nxt:4218065811 snd_nxt:648617715 snd:una:648617715
> > > > > > > > mss_cache:32768
> > > > > > > > ecn_flags:0 rate_delivered:1 rate_interval_us:925
> > > > > > > > packets_out:0
> > > > > > > > retrans_out:0 total_retrans:0 segs_in:4 data_segs_in:2
> > > > > > > > segs_out:6
> > > > > > > > data_segs_out:0 lost_out:0 sacked_out:0
> > > > > > > > bytes_received:23
> > > > > > > > bytes_acked:2
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_result:PASS:listen_sk =
0 nsec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_result:PASS:srv_sk 0 n=
sec
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_result:PASS:srv_tp 0 n=
sec
> > > > > > > >=20
> > > > > > > > If bpf program is compiled with llvm16, the test passed
> > > > > > > > according
> > > > > > > > to
> > > > > > > > a CI run.
> > > > > > > >=20
> > > > > > > > I don't have s390x environment to debug this. Could you
> > > > > > > > help
> > > > > > > > debug
> > > > > > > > it?
> > > > > > > >=20
> > > > > > > > Thanks!
> > > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [1]
> > > > > > > > https://github.com/kernel-patches/vmtest/actions/runs/48668=
51496/jobs/8679080985?pr=3D224#step:6:7645
> > > > > > >=20
> > > > > > >=20
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > thank for letting me know.
> > > > > > > I will look into this.
> > > > > > >=20
> > > > > > > Best regards,
> > > > > > > Ilya
> > > > > >=20
> > > > > > In the meantime the issue was fixed by:
> > > > > >=20
> > > > > > commit 141be5c062ecf22bd287afffd310e8ac4711444a
> > > > > > Author: Shoaib Meenai <smeenai@fb.com>
> > > > > > Date:=C2=A0=C2=A0 Fri May 5 14:18:12 2023 -0700
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Revert "Reland [Pipeline] =
Don't limit
> > > > > > ArgumentPromotion
> > > > > > to -
> > > > > > O3"
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This reverts commit
> > > > > > 6f29d1adf29820daae9ea7a01ae2588b67735b9e.
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://reviews.llvm.org/D=
149768=C2=A0=C2=A0=C2=A0 is causing size
> > > > > > regressions
> > > > > > for -
> > > > > > Oz
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with FullLTO, and I'm reve=
rting that one while
> > > > > > investigating.
> > > > > > This
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit depends on that one=
, so it needs to be
> > > > > > reverted as
> > > > > > well.
> > > > >=20
> > > > > The transformtion "Don't limit ArgumentPromotion to -O3" is
> > > > > temporarily
> > > > > reverted. But it could be reverted again once the issue is
> > > > > resolved.
> > > > > So it is a good idea to resolve the issue in the kernel.
> > > > >=20
> > > > > >=20
> > > > > > But looking at the codegen differences:
> > > > > >=20
> > > > > > $ diff -u <(sed -e s/[0-9]*://g pass.s) <(sed -e s/[0-
> > > > > > 9]*://g
> > > > > > fail.s)
> > > > > >=20
> > > > > > -pass.o:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file format =
elf64-bpf
> > > > > > +fail.o:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file format =
elf64-bpf
> > > > > >=20
> > > > > > -00000000000002c8 <sk_dst_port__load_half>
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 69 11 00 30 00 00 00 00 r=
1 =3D *(u16 *)(r1 + 48)
> > > > > > +00000000000002c0 <sk_dst_port__load_half>
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 54 10 00 00 00 00 ff ff w=
1 &=3D 65535
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b4=
 00 00 00 00 00 00 01 w0 =3D 1
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=
 10 00 01 00 00 ca fe if w1 =3D=3D 51966 goto +1
> > > > > > <LBB6_2>
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b4=
 00 00 00 00 00 00 00 w0 =3D 0
> > > > > >=20
> > > > > > This is what ArgumentPromotion is supposed to do, so that's
> > > > > > okay so
> > > > > > far. However, further down below we have:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 Disassembly of section cgroup_skb/egress:
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bf 16 00 00 00 00 00 00 r=
1 =3D r6
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 61 76 00 30 00 00 00 00 r=
7 =3D *(u32 *)(r6 + 48)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bc 17 00 00 00 00 00 00 w=
1 =3D w7
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 85=
 01 00 00 00 00 00 53 call
> > > > > > sk_dst_port__load_word
> > > > > >=20
> > > > > > ...
> > > > > >=20
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bf 16 00 00 00 00 00 00 r=
1 =3D r6
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 74 70 00 00 00 00 00 10 w=
7 >>=3D 16
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bc 17 00 00 00 00 00 00 w=
1 =3D w7
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 85=
 01 00 00 00 00 00 57 call
> > > > > > sk_dst_port__load_half
> > > > > >=20
> > > > > > so there is no 16-bit load anymore, instead, the result
> > > > > > from
> > > > > > the
> > > > > > earlier 32-bit load is reused. However, on BE these kinds
> > > > > > of
> > > > > > loads
> > > > > > for this particular field are not consistent at the moment
> > > > > > -
> > > > > > see
> > > > > > [1]
> > > > > > and the previous discussions.
> > > > > >=20
> > > > > > De-facto we have the following results:
> > > > > >=20
> > > > > > - int load: 0x0000cafe
> > > > > > - short load: 0xcafe
> > > > >=20
> > > > > So 'De-facto' means the above is the expected result.
> > > > >=20
> > > > > >=20
> > > > > > On a consistent BE we should have rather had:
> > > > > >=20
> > > > > > - int load: 0x0000cafe
> > > > > > - short load: 0
> > > > >=20
> > > > > What does 'consistent BE' mean here? Does it mean the
> > > > > expected
> > > > > result from the source code itself?
> > > >=20
> > > > I should not have called the de-facto example "BE" at all: it's
> > > > rather
> > > > "mixed endianness" or "weird endianness" or something along
> > > > these
> > > > lines.
> > > >=20
> > > > On "consistent BE" or simply "BE" properties like
> > > >=20
> > > > *(uint32_t *)p =3D (*(uint16_t *)p << 16) | *(uint16_t *)(p + 2);
> > > >=20
> > > > hold. This is currently not the case for bpf_sock.dst_port.
> > > >=20
> > > > We compile with -mbig-endian, so we promise to the compiler
> > > > that
> > > > the
> > > > machine is big-endian, and the compiler expects the above to
> > > > hold
> > > > for
> > > > any p. Unfortunately when p points to bpf_sock.dst_port, this
> > > > is
> > > > not
> > > > the case.
> > >=20
> > > If I understand correctly, *(uint32_t *)p to get the
> > > bpf_sock.dst_port
> > > is for backward compatibility. But the real u32 read by compiler
> > > will
> > > do (*(uint16_t *)p << 16) | *(uint16_t *)(p + 2) which is not the
> > > same as expected *(uint32_t *)p so we have problem here.
> > >=20
> > > >=20
> > > > The property above is important for the correctness of the
> > > > load/store
> > > > tearing transformations. What we have here is not exactly
> > > > tearing,
> > > > but
> > > > is quite close.
> > > >=20
> > > > > > Clang, of course, expects a consistent BE and optimizes
> > > > > > around
> > > > > > that.
> > > > > >=20
> > > > > > This was a conscious tradeoff Jakub and I have agreed on in
> > > > > > order
> > > > > > to
> > > > > > keep the quirky behavior from the past. Given what's
> > > > > > happening
> > > > > > with
> > > > > > Clang now, I wonder if it would be worth revisiting it in
> > > > > > the
> > > > > > name
> > > > > > of
> > > > > > consistency?
> > > > >=20
> > > > > If I understand correctly, I think the issue is
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r7 =3D *(u32 *)(r6 + 48)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w7 >=3D 16
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w1 =3D w7
> > > > >=20
> > > > > after verifier, it is changed to
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r7 =3D *(u16 *)(r6 + <kernel offse=
t>)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w7 >=3D 16
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w1 =3D w7
> > > > >=20
> > > > > and the result after verifier rewrite is completely wrong.
> > > > > Is it right?
> > > >=20
> > > > No, the verifier rewrite is correct.
> > > > The sk_dst_port__load_word() part of the test succeeds.
> > > >=20
> > > > All these rewrites already work fine, they are correct and
> > > > consistent.
> > > > It's really just bpf_sock.dst_port that is special.
> > > >=20
> > > > > If this is the case, during verifier rewrite, if it is
> > > > > big endian, say the user intends to load 4 bytes (from uapi
> > > > > header)
> > > > > while the kernel field is 2 bytes, in such cases, kernel
> > > > > can still pretend to generate 4-byte load. For example,
> > > > > for the above example, the code after verification could be:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r7 =3D *(u16 *)(r6 + <kernel offse=
t>)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r7 <=3D 16
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w7 >=3D 16
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w1 =3D w7
> > > > >=20
> > > > > Hopefully, we won't have many such cases. Does this work?
> > > >=20
> > > > This would break the sk_dst_port__load_word() part of the test.
> > >=20
> > > This is a hack. This may work for this specific u16 case, but
> > > yes, it won't work for u32 load case.
> > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > Above I asked whether we can resolve the inconsistency, but I
> > > > thought
> > > > about it and I don't see a way of doing it without breaking the
> > > > ABI,
> > > > which is at worst unacceptable, and at best a last resort
> > > > measure.
> > > >=20
> > > > What do you think about marking bpf_sock.dst_port volatile?
> > > > volatile
> > > > should prevent tearing and similar optimizations, with which we
> > > > have a
> > > > problem here.
> > > >=20
> > > > We could also add a comment warning users not to cast away this
> > > > volatile due to the quirk we have. And then we should adjust
> > > > the
> > > > test
> > > > (making all casts volatile) to comply with this new warning.
> > >=20
> > > I did a little study on this. The main problem here for
> > > static __noinline bool sk_dst_port__load_half(struct bpf_sock
> > > *sk)
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u16 *half =
=3D (__u16 *)&sk->dst_port;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return half[0]=
 =3D=3D bpf_htons(0xcafe);
> > > }
> > >=20
> > > Through some cross-function optimization by ArgumentPromotion
> > > optimization, the compiler does:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 /* the below shared by sk_dst_port__load_word
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and sk_dst_port__load_half
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > =C2=A0=C2=A0=C2=A0=C2=A0 __u32 *word =3D (__u32 *)&sk->dst_port;
> > > =C2=A0=C2=A0=C2=A0=C2=A0 __u32 word_val =3D word[0];
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 /* the below is for sk_dst_port__load_half o=
nly */
> > > =C2=A0=C2=A0=C2=A0=C2=A0 __u16 half_val =3D word_val >> 16;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 ... half_val passed into sk_dst_port__load_h=
alf ...
> > > =C2=A0=C2=A0=C2=A0=C2=A0 return half_val =3D=3D bpf_htons(0xcafe);
> > >=20
> > > Here, 'word_val =3D word[0]' is replaced by 2-byte load
> > > by the verifier and this caused the trouble for later
> > > sk_dst_port__load_half().
> > >=20
> > > I don't have a good solution here. The issue is exposed
> > > as we have both u16 and u32 load for &sk->dst_port and
> > > the compiler did some optimization with this.
> > >=20
> > > I would say this is an extreme corner case and we can just
> > > fix in the source code like below:
> > >=20
> > > diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c
> > > b/tools/testing/selftests/bpf/progs/test_sock_fields.c
> > > index bbad3c2d9aa5..39c975786720 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
> > > @@ -265,7 +265,10 @@ static __noinline bool
> > > sk_dst_port__load_word(struct bpf_sock *sk)
> > >=20
> > > =C2=A0=C2=A0 static __noinline bool sk_dst_port__load_half(struct bpf=
_sock
> > > *sk)
> > > =C2=A0=C2=A0 {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u16 *half =3D (__u16 *)&sk->d=
st_port;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u16 *half;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm volatile ("");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 half=C2=A0 =3D (__u16 *)&sk->ds=
t_port;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return half[0]=
 =3D=3D bpf_htons(0xcafe);
> > > =C2=A0=C2=A0 }
> > >=20
> > > Could you try whether the above workaround works or not?
> > > If we want the code to be future proof for potential
> > > cross-func optimization for these noinline functions, we
> > > can add similar asm codes to all of
> > > bool sk_dst_port__load_{word, half, byte}.
> >=20
> > Hi,
> >=20
> > this makes the issue go away, thanks.
> >=20
> > However, I'm still concerned, because this only inhibits a certain
> > optimization and does not address the underlying fundamental
> > problem:
> > we promise to clang that the in-kernel implementation of the eBPF
> > virtual machine is big-endian, while in reality it's not. As
> > compiler
> > optimizations get more aggressive, we will surely see more of this.
> >=20
> > Why not do this instead?
> >=20
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 1bb11a6ee667..3c9b535532ae 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6102,7 +6102,7 @@ struct bpf_sock {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32 src_ip4;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32 src_ip6[4];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32 src_port;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* host byte order */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__be16 dst_port;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* network byte order */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0volatile __be16 dst_port;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* network byte order */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u16 :16;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* =
zero padding */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32 dst_ip4;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32 dst_ip6[4];
> > diff --git a/tools/include/uapi/linux/bpf.h
> > b/tools/include/uapi/linux/bpf.h
> > index 1bb11a6ee667..3c9b535532ae 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -6102,7 +6102,7 @@ struct bpf_sock {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32 src_ip4;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32 src_ip6[4];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32 src_port;=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* host byte order */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__be16 dst_port;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* network byte order */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0volatile __be16 dst_port;=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* network byte order */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u16 :16;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* =
zero padding */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32 dst_ip4;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32 dst_ip6[4];
> > diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c
> > b/tools/testing/selftests/bpf/progs/test_sock_fields.c
> > index bbad3c2d9aa5..773ded84ac12 100644
> > --- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
> > +++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
> > @@ -259,19 +259,19 @@ int ingress_read_sock_fields(struct __sk_buff
> > *skb)
> > =C2=A0=C2=A0 */
> > =C2=A0 static __noinline bool sk_dst_port__load_word(struct bpf_sock
> > *sk)
> > =C2=A0 {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u32 *word =3D (__u32 *)&sk=
->dst_port;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0volatile __u32 *word =3D (vo=
latile __u32 *)&sk->dst_port;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return word[0] =3D=3D b=
pf_htons(0xcafe);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static __noinline bool sk_dst_port__load_half(struct bpf_sock
> > *sk)
> > =C2=A0 {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u16 *half =3D (__u16 *)&sk=
->dst_port;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0volatile __u16 *half =3D (vo=
latile __u16 *)&sk->dst_port;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return half[0] =3D=3D b=
pf_htons(0xcafe);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static __noinline bool sk_dst_port__load_byte(struct bpf_sock
> > *sk)
> > =C2=A0 {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__u8 *byte =3D (__u8 *)&sk->=
dst_port;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0volatile __u8 *byte =3D (vol=
atile __u8 *)&sk->dst_port;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return byte[0] =3D=3D 0=
xca && byte[1] =3D=3D 0xfe;
> > =C2=A0 }
> > =C2=A0=20
> > This also works, and as far as I'm concerned, this would be a
> > proper
> > fix for the underlying issue: we tell the compiler that it should
> > never
> > ever (with any of today's or future optimizations) try to be clever
> > when accessing dst_port.
>=20
> The above test_sock_fields.c change should work too.
> I think the uapi change is not necessary. The key word 'volatile'
> intends to avoid merging two or more identical loads together.
> In this particular case, with only uapi changes, the
> harmful transformation can still happen since the sk->dst_port
> is indeed loaded only once.
>=20
> The test_sock_fields.c change itself forces proper load
> which is verifier friendly. So I suggest to have
> test_sock_fields.c change only. My previously suggested
> changes have the same effect, to preserve the verifier friendly
> load.

Ok, let's do it this way then.

Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>

for the diff you posted above.

>=20
> >=20
> > Best regards,
> > Ilya
> >=20
> >=20
> > > > > > [1]
> > > > > > https://lore.kernel.org/bpf/20220317113920.1068535-5-jakub@clou=
dflare.com
> >=20


