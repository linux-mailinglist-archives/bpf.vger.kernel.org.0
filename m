Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681656F5F63
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjECTrG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjECTrF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 15:47:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29664C2E
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 12:47:03 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343JWfDs026447;
        Wed, 3 May 2023 19:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=F+wV+cTioGeQVGHtUZPRW/l3zsTwJVqfL+aGSQfe8XU=;
 b=GWZOU8+5JM6kLdf2U/QSpWg7pSHXIclRh98qjKRffhDRPfcL0A49hQRui9wdb204Ien4
 XqQcekUyiALy3wqSTVS+OcoBDQNBK7kpCfW+B2OL/biegtKsMMN/lvaH1InC6fHOwNQJ
 2NhVW01KKEbmIwvIqkkIbICP71NwE/Q8/LujZALRFBHxBl706FuF/J0sp5cva8JYuWcU
 zVy5O0gIIiUyIJ2N/xvGVP8UKSRqGJY2s2L0e9s65IzoD7s/vC3D7MzS7IKF+ZTsgCi4
 E1chxgzlWaE6LBcGplWXxdQlU0I2xZ4chpC3YJYe7Pog3gePdusSU/LQYyfKeTkPzOmK dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qbwnartfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 19:47:01 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 343JkEp8000933;
        Wed, 3 May 2023 19:46:35 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qbwnars2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 19:46:34 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 343H9Q4Q011361;
        Wed, 3 May 2023 19:46:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3q8tv6t10c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 19:46:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 343Jk98R24511114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 May 2023 19:46:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35C732004E;
        Wed,  3 May 2023 19:46:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8B302004B;
        Wed,  3 May 2023 19:46:08 +0000 (GMT)
Received: from [9.171.18.250] (unknown [9.171.18.250])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  3 May 2023 19:46:08 +0000 (GMT)
Message-ID: <daf235c37af3790f7dd7c1b2089617d49fad7b6e.camel@linux.ibm.com>
Subject: Re: selftest sock_fields failed on s390x with latest llvm17
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@meta.com>,
        Manu Bretelle <chantr4@gmail.com>
Date:   Wed, 03 May 2023 21:46:08 +0200
In-Reply-To: <e7f2c5e8-a50c-198d-8f95-388165f1e4fd@meta.com>
References: <e7f2c5e8-a50c-198d-8f95-388165f1e4fd@meta.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N3RbTpVLSyvz00AZOz5q7sypDmU7iIwL
X-Proofpoint-ORIG-GUID: ixcBWaU6T6NtmhunhfRgs4O8BzPtylzx
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=895 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030168
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-05-03 at 12:35 -0700, Yonghong Song wrote:
> Hi, Ilya,
>=20
> BPF CI ([1]) detected a s390x failure when bpf program is compiled
> with=20
> latest llvm17 on bpf-next branch. To reproduce the issue, just run=20
> normal './test_progs -j'. The failure log looks like below:
>=20
> Notice: Success: 341/3015, Skipped: 29, Failed: 1
> Error: #191 sock_fields
> =C2=A0=C2=A0 Error: #191 sock_fields
> =C2=A0=C2=A0 create_netns:PASS:create netns 0 nsec
> =C2=A0=C2=A0 create_netns:PASS:bring up lo 0 nsec
> =C2=A0=C2=A0 serial_test_sock_fields:PASS:test_sock_fields__open_and_load=
 0
> nsec
> =C2=A0=C2=A0
> serial_test_sock_fields:PASS:attach_cgroup(egress_read_sock_fields) 0
> nsec
> =C2=A0=C2=A0
> serial_test_sock_fields:PASS:attach_cgroup(ingress_read_sock_fields)=20
> 0 nsec
> =C2=A0=C2=A0 serial_test_sock_fields:PASS:attach_cgroup(read_sk_dst_port =
0 nsec
> =C2=A0=C2=A0 test:PASS:getsockname(listen_fd) 0 nsec
> =C2=A0=C2=A0 test:PASS:getsockname(cli_fd) 0 nsec
> =C2=A0=C2=A0 test:PASS:accept(listen_fd) 0 nsec
> =C2=A0=C2=A0 init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt_fd) =
0 nsec
> =C2=A0=C2=A0 init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt10_fd=
) 0
> nsec
> =C2=A0=C2=A0 test:PASS:send(accept_fd) 0 nsec
> =C2=A0=C2=A0 test:PASS:recv(cli_fd) 0 nsec
> =C2=A0=C2=A0 test:PASS:send(accept_fd) 0 nsec
> =C2=A0=C2=A0 test:PASS:recv(cli_fd) 0 nsec
> =C2=A0=C2=A0 test:PASS:recv(accept_fd) for fin 0 nsec
> =C2=A0=C2=A0 test:PASS:recv(cli_fd) for fin 0 nsec
> =C2=A0=C2=A0 check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cnt=
,=20
> &accept_fd) 0 nsec
> =C2=A0=C2=A0 check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cnt=
,=20
> &cli_fd) 0 nsec
> =C2=A0=C2=A0 check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0 nsec
> =C2=A0=C2=A0 check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0 nsec
> =C2=A0=C2=A0 check_result:PASS:bpf_map_lookup_elem(linum_map_fd,=20
> READ_SK_DST_PORT_IDX) 0 nsec
> =C2=A0=C2=A0 check_result:FAIL:failure in read_sk_dst_port on line unexpe=
cted=20
> failure in read_sk_dst_port on line: actual 297 !=3D expected 0
> =C2=A0=C2=A0 listen_sk: state:10 bound_dev_if:0 family:10 type:1 protocol=
:6
> mark:0=20
> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)=20
> src_port:51966 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:0(::) dst_port:0
> =C2=A0=C2=A0 srv_sk: state:9 bound_dev_if:0 family:10 type:1 protocol:6 m=
ark:0=20
> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)=20
> src_port:51966 dst_ip4:7f000006(127.0.0.6) dst_ip6:0:0:0:1(::1)=20
> dst_port:38030
> =C2=A0=C2=A0 cli_sk: state:5 bound_dev_if:0 family:10 type:1 protocol:6 m=
ark:0=20
> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)=20
> src_port:38030 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:1(::1) dst_port:51966
> =C2=A0=C2=A0 listen_tp: snd_cwnd:10 srtt_us:0 rtt_min:4294967295=20
> snd_ssthresh:2147483647 rcv_nxt:0 snd_nxt:0 snd:una:0 mss_cache:536=20
> ecn_flags:0 rate_delivered:0 rate_interval_us:0 packets_out:0=20
> retrans_out:0 total_retrans:0 segs_in:0 data_segs_in:0 segs_out:0=20
> data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:0
> bytes_acked:0
> =C2=A0=C2=A0 srv_tp: snd_cwnd:10 srtt_us:3904 rtt_min:272
> snd_ssthresh:2147483647=20
> rcv_nxt:648617715 snd_nxt:4218065810 snd:una:4218065810
> mss_cache:32768=20
> ecn_flags:0 rate_delivered:1 rate_interval_us:272 packets_out:0=20
> retrans_out:0 total_retrans:0 segs_in:5 data_segs_in:0 segs_out:3=20
> data_segs_out:2 lost_out:0 sacked_out:0 bytes_received:1
> bytes_acked:22
> =C2=A0=C2=A0 cli_tp: snd_cwnd:10 srtt_us:6035 rtt_min:730
> snd_ssthresh:2147483647=20
> rcv_nxt:4218065811 snd_nxt:648617715 snd:una:648617715
> mss_cache:32768=20
> ecn_flags:0 rate_delivered:1 rate_interval_us:925 packets_out:0=20
> retrans_out:0 total_retrans:0 segs_in:4 data_segs_in:2 segs_out:6=20
> data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:23
> bytes_acked:2
> =C2=A0=C2=A0 check_result:PASS:listen_sk 0 nsec
> =C2=A0=C2=A0 check_result:PASS:srv_sk 0 nsec
> =C2=A0=C2=A0 check_result:PASS:srv_tp 0 nsec
>=20
> If bpf program is compiled with llvm16, the test passed according to
> a CI run.
>=20
> I don't have s390x environment to debug this. Could you help debug
> it?
>=20
> Thanks!
>=20
> =C2=A0=C2=A0 [1]=20
> https://github.com/kernel-patches/vmtest/actions/runs/4866851496/jobs/867=
9080985?pr=3D224#step:6:7645


Hi,

thank for letting me know.
I will look into this.

Best regards,
Ilya
