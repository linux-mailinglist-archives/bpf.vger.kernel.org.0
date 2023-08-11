Return-Path: <bpf+bounces-7526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E533E77892D
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 10:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A2A2820DA
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 08:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8C353B9;
	Fri, 11 Aug 2023 08:48:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C301869;
	Fri, 11 Aug 2023 08:48:15 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A9130C1;
	Fri, 11 Aug 2023 01:48:13 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B8edTZ024271;
	Fri, 11 Aug 2023 08:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : mime-version : content-type; s=pp1;
 bh=tyh5cDZWabZQwh7mE9BXjoP5MVCyfN6HDYx2RPApJoU=;
 b=AE6H5nbbtCjtT6P0Stv2ibvq/SSBiM2XQRogRVvjU+J6YsH/Q8+TqwDuqg2kce9iPN1X
 abj4Y3vzAAhY4DJ4+cRCoxJzXWhpD62GPlQQctyLM/1k9Ff/V7c1EVaSvo5B3fBPt4dH
 x0KzRDYhQ2YhNqAErttiIaeWtI92VlKWBkd4SFJuKm9sts3wWzx9VtSJmRuaHS+ZurpB
 dXHo7TUR+N3niZUXK34bDmY5XFeB8GykZgKUFuWD5VmEQZx5y73HKw41n4Y+C+cMK2Sr
 duNkOj9Rc+dG7g8a3iTvujnf+4SP0opPA1svGODvgiHTOvToUWfTvaEKQx6rTyi9HOV5 mw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdhh186nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 08:47:47 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37B8hSZ2000377;
	Fri, 11 Aug 2023 08:47:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdhh186mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 08:47:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37B7BDmP015363;
	Fri, 11 Aug 2023 08:47:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sb3f3jvxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 08:47:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37B8lhS515205064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 08:47:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D553420043;
	Fri, 11 Aug 2023 08:47:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94F6D20040;
	Fri, 11 Aug 2023 08:47:40 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 11 Aug 2023 08:47:40 +0000 (GMT)
Date: Fri, 11 Aug 2023 14:17:39 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: Warning when compiling with python3.12
Message-ID: <20230811084739.GY3902@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iwD2xyczQJf4rg4xj5rqU1N8irk6mZ_s
X-Proofpoint-GUID: rP9qckL4ZgKbijb2-20T1zBsL0UGXTAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

When trying to build on v6.5-rc4 with python 3.12 aka Python 3.12.0rc1 I am
hitting the below Warning messages.

I didn't see something similar reported upstream, hence thought of reporting.

/home/srikar/linux.git/scripts/bpf_doc.py:62: SyntaxWarning: invalid escape sequence '\w'
  arg_re = re.compile('((\w+ )*?(\w+|...))( (\**)(\w+))?$')
/home/srikar/linux.git/scripts/bpf_doc.py:64: SyntaxWarning: invalid escape sequence '\*'
  proto_re = re.compile('(.+) (\**)(\w+)\(((([^,]+)(, )?){1,5})\)$')
/home/srikar/linux.git/scripts/bpf_doc.py:117: SyntaxWarning: invalid escape sequence '\*'
  p = re.compile(' \* ?(BPF\w+)$')
/home/srikar/linux.git/scripts/bpf_doc.py:121: SyntaxWarning: invalid escape sequence '\*'
  end_re = re.compile(' \* ?NOTES$')
/home/srikar/linux.git/scripts/bpf_doc.py:136: SyntaxWarning: invalid escape sequence '\*'
  p = re.compile(' \* ?((.+) \**\w+\((((const )?(struct )?(\w+|\.\.\.)( \**\w+)?)(, )?){1,5}\))$')
/home/srikar/linux.git/scripts/bpf_doc.py:144: SyntaxWarning: invalid escape sequence '\*'
  p = re.compile(' \* ?(?:\t| {5,8})Description$')
/home/srikar/linux.git/scripts/bpf_doc.py:157: SyntaxWarning: invalid escape sequence '\*'
  p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
/home/srikar/linux.git/scripts/bpf_doc.py:170: SyntaxWarning: invalid escape sequence '\*'
  p = re.compile(' \* ?(?:\t| {5,8})Return$')
/home/srikar/linux.git/scripts/bpf_doc.py:183: SyntaxWarning: invalid escape sequence '\*'
  p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
/home/srikar/linux.git/scripts/bpf_doc.py:222: SyntaxWarning: invalid escape sequence '\s'
  bpf_p = re.compile('\s*(BPF\w+)+')
/home/srikar/linux.git/scripts/bpf_doc.py:227: SyntaxWarning: invalid escape sequence '\s'
  assign_p = re.compile('\s*(BPF\w+)\s*=\s*(BPF\w+)')
/home/srikar/linux.git/scripts/bpf_doc.py:242: SyntaxWarning: invalid escape sequence '\w'
  self.enum_syscalls = re.findall('(BPF\w+)+', bpf_cmd_str)
/home/srikar/linux.git/scripts/bpf_doc.py:266: SyntaxWarning: invalid escape sequence '\s'
  p = re.compile('\s*FN\((\w+), (\d+), ##ctx\)|\\\\')
/home/srikar/linux.git/scripts/bpf_doc.py:281: SyntaxWarning: invalid escape sequence '\('
  self.define_unique_helpers = re.findall('FN\(\w+, \d+, ##ctx\)', fn_defines_str)
/home/srikar/linux.git/scripts/bpf_doc.py:428: SyntaxWarning: invalid escape sequence '\*'
  '/{}/,/\*\//:include/uapi/linux/bpf.h'.format(delimiter)]
/home/srikar/linux.git/scripts/bpf_doc.py:499: SyntaxWarning: invalid escape sequence '\ '
  footer = '''
/home/srikar/linux.git/scripts/bpf_doc.py:601: SyntaxWarning: invalid escape sequence '\ '
  one_arg += ' {}**\ '.format(a['star'].replace('*', '\\*'))

However I am not seeing this when using python 3.10 (Python 3.10.12) and
python 3.11 (Python 3.11.4). Note this is just a warning and Kernel build does
complete.

-- 
Thanks and Regards
Srikar Dronamraju

