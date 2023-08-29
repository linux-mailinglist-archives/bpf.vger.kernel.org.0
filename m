Return-Path: <bpf+bounces-8883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB078BF74
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 09:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118EF280FE5
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2463CB;
	Tue, 29 Aug 2023 07:44:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BF123D2;
	Tue, 29 Aug 2023 07:44:17 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE81A132;
	Tue, 29 Aug 2023 00:44:15 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T7eOAi005045;
	Tue, 29 Aug 2023 07:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XGvN6eeoHenoz3hwGgm4JUCstggrGxRpB0rSiz9bFGY=;
 b=LD6t82qLye8nLpVTABw3/jRfHaJxdbokS2hdFvhWQ25Doim/1rilO85MbkBuhrtuRdhC
 ZRWACaw+Z+R4UXXC+ifD84MJ+IO9OTODucVDhRdwjAhm4qbXHh5uQ6RcBhRz8PqWmyLZ
 cgL2Cfv+yiLnRQqycXhe1rzhYHTuUCWRgtq8OKPbNQRStIjGNxP6fzVBIFoMbwrfUBb/
 2SDk7+kId7PRDAgZG55vBuFEx/cX/veETWhJDN3kL+qgmNX6pAJhEZr+ydY+mzG8ooYT
 2IqYC9pg8aMSLZyx4CWJFUhEZJL18TAwx0KVtXxFdlwISctooY+XOOqo+Alq/tU7H0Ee RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sradyktqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 07:43:56 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37T7gfqK012782;
	Tue, 29 Aug 2023 07:43:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sradyktqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 07:43:56 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37T6fHU8020514;
	Tue, 29 Aug 2023 07:43:55 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3y9vv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 07:43:55 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37T7hsVE60358934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Aug 2023 07:43:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF2F5805A;
	Tue, 29 Aug 2023 07:43:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8C0358056;
	Tue, 29 Aug 2023 07:43:47 +0000 (GMT)
Received: from [9.171.49.19] (unknown [9.171.49.19])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Aug 2023 07:43:47 +0000 (GMT)
Message-ID: <e640e5f2-381c-4f65-40b9-c2e3e94696f9@linux.ibm.com>
Date: Tue, 29 Aug 2023 13:13:46 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Fix invalid escape sequence warnings
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Cc: srikar@linux.vnet.ibm.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        netdev@vger.kernel.org, sachinp@linux.ibm.com, sdf@google.com,
        song@kernel.org, yhs@fb.com
References: <20230811084739.GY3902@linux.vnet.ibm.com>
 <20230816122133.1231599-1-vishalc@linux.ibm.com>
 <CAEf4BzZeCzEUM+=D7F5vNAe3fgmbGf0qo_DQ1nKSUJ-G78iFyw@mail.gmail.com>
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <CAEf4BzZeCzEUM+=D7F5vNAe3fgmbGf0qo_DQ1nKSUJ-G78iFyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ge6dIjHwnFNoUIIQk3oPV_Nl9QSbHr9E
X-Proofpoint-ORIG-GUID: uv4MV2n35AHjVNEFA0_eFeWGwMVo4FWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_04,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1011
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290064
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/23/23 05:00, Andrii Nakryiko wrote:
> On Wed, Aug 16, 2023 at 5:22 AM Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>>
>> The Python script `bpf_doc.py` uses regular expressions with
>> backslashes in string literals, which results in SyntaxWarnings
>> during its execution.
>>
>> This patch addresses these warnings by converting relevant string
>> literals to raw strings, which interpret backslashes as literal
>> characters. This ensures that the regular expressions are parsed
>> correctly without causing any warnings.
>>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>>
>> ---
>>  scripts/bpf_doc.py | 34 +++++++++++++++++-----------------
>>  1 file changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index eaae2ce78381..dfd819c952b2 100755
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -59,9 +59,9 @@ class Helper(APIElement):
>>          Break down helper function protocol into smaller chunks: return type,
>>          name, distincts arguments.
>>          """
>> -        arg_re = re.compile('((\w+ )*?(\w+|...))( (\**)(\w+))?$')
>> +        arg_re = re.compile(r'((\w+ )*?(\w+|...))( (\**)(\w+))?$')
>>          res = {}
>> -        proto_re = re.compile('(.+) (\**)(\w+)\(((([^,]+)(, )?){1,5})\)$')
>> +        proto_re = re.compile(r'(.+) (\**)(\w+)\(((([^,]+)(, )?){1,5})\)$')
>>
>>          capture = proto_re.match(self.proto)
>>          res['ret_type'] = capture.group(1)
>> @@ -114,11 +114,11 @@ class HeaderParser(object):
>>          return Helper(proto=proto, desc=desc, ret=ret)
>>
>>      def parse_symbol(self):
>> -        p = re.compile(' \* ?(BPF\w+)$')
>> +        p = re.compile(r' \* ?(BPF\w+)$')
>>          capture = p.match(self.line)
>>          if not capture:
>>              raise NoSyscallCommandFound
>> -        end_re = re.compile(' \* ?NOTES$')
>> +        end_re = re.compile(r' \* ?NOTES$')
>>          end = end_re.match(self.line)
>>          if end:
>>              raise NoSyscallCommandFound
>> @@ -133,7 +133,7 @@ class HeaderParser(object):
>>          #   - Same as above, with "const" and/or "struct" in front of type
>>          #   - "..." (undefined number of arguments, for bpf_trace_printk())
>>          # There is at least one term ("void"), and at most five arguments.
>> -        p = re.compile(' \* ?((.+) \**\w+\((((const )?(struct )?(\w+|\.\.\.)( \**\w+)?)(, )?){1,5}\))$')
>> +        p = re.compile(r' \* ?((.+) \**\w+\((((const )?(struct )?(\w+|\.\.\.)( \**\w+)?)(, )?){1,5}\))$')
>>          capture = p.match(self.line)
>>          if not capture:
>>              raise NoHelperFound
>> @@ -141,7 +141,7 @@ class HeaderParser(object):
>>          return capture.group(1)
>>
>>      def parse_desc(self, proto):
>> -        p = re.compile(' \* ?(?:\t| {5,8})Description$')
>> +        p = re.compile(r' \* ?(?:\t| {5,8})Description$')
>>          capture = p.match(self.line)
>>          if not capture:
>>              raise Exception("No description section found for " + proto)
>> @@ -154,7 +154,7 @@ class HeaderParser(object):
>>              if self.line == ' *\n':
>>                  desc += '\n'
>>              else:
>> -                p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
>> +                p = re.compile(r' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
>>                  capture = p.match(self.line)
>>                  if capture:
>>                      desc_present = True
>> @@ -167,7 +167,7 @@ class HeaderParser(object):
>>          return desc
>>
>>      def parse_ret(self, proto):
>> -        p = re.compile(' \* ?(?:\t| {5,8})Return$')
>> +        p = re.compile(r' \* ?(?:\t| {5,8})Return$')
>>          capture = p.match(self.line)
>>          if not capture:
>>              raise Exception("No return section found for " + proto)
>> @@ -180,7 +180,7 @@ class HeaderParser(object):
>>              if self.line == ' *\n':
>>                  ret += '\n'
>>              else:
>> -                p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
>> +                p = re.compile(r' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
>>                  capture = p.match(self.line)
>>                  if capture:
>>                      ret_present = True
>> @@ -219,12 +219,12 @@ class HeaderParser(object):
>>          self.seek_to('enum bpf_cmd {',
>>                       'Could not find start of bpf_cmd enum', 0)
>>          # Searches for either one or more BPF\w+ enums
>> -        bpf_p = re.compile('\s*(BPF\w+)+')
>> +        bpf_p = re.compile(r'\s*(BPF\w+)+')
>>          # Searches for an enum entry assigned to another entry,
>>          # for e.g. BPF_PROG_RUN = BPF_PROG_TEST_RUN, which is
>>          # not documented hence should be skipped in check to
>>          # determine if the right number of syscalls are documented
>> -        assign_p = re.compile('\s*(BPF\w+)\s*=\s*(BPF\w+)')
>> +        assign_p = re.compile(r'\s*(BPF\w+)\s*=\s*(BPF\w+)')
>>          bpf_cmd_str = ''
>>          while True:
>>              capture = assign_p.match(self.line)
>> @@ -239,7 +239,7 @@ class HeaderParser(object):
>>                  break
>>              self.line = self.reader.readline()
>>          # Find the number of occurences of BPF\w+
>> -        self.enum_syscalls = re.findall('(BPF\w+)+', bpf_cmd_str)
>> +        self.enum_syscalls = re.findall(r'(BPF\w+)+', bpf_cmd_str)
>>
>>      def parse_desc_helpers(self):
>>          self.seek_to(helpersDocStart,
>> @@ -263,7 +263,7 @@ class HeaderParser(object):
>>          self.seek_to('#define ___BPF_FUNC_MAPPER(FN, ctx...)',
>>                       'Could not find start of eBPF helper definition list')
>>          # Searches for one FN(\w+) define or a backslash for newline
>> -        p = re.compile('\s*FN\((\w+), (\d+), ##ctx\)|\\\\')
>> +        p = re.compile(r'\s*FN\((\w+), (\d+), ##ctx\)|\\\\')
>>          fn_defines_str = ''
>>          i = 0
>>          while True:
>> @@ -278,7 +278,7 @@ class HeaderParser(object):
>>                  break
>>              self.line = self.reader.readline()
>>          # Find the number of occurences of FN(\w+)
>> -        self.define_unique_helpers = re.findall('FN\(\w+, \d+, ##ctx\)', fn_defines_str)
>> +        self.define_unique_helpers = re.findall(r'FN\(\w+, \d+, ##ctx\)', fn_defines_str)
>>
>>      def validate_helpers(self):
>>          last_helper = ''
>> @@ -425,7 +425,7 @@ class PrinterRST(Printer):
>>          try:
>>              cmd = ['git', 'log', '-1', '--pretty=format:%cs', '--no-patch',
>>                     '-L',
>> -                   '/{}/,/\*\//:include/uapi/linux/bpf.h'.format(delimiter)]
>> +                   r'/{}/,/\*\//:include/uapi/linux/bpf.h'.format(delimiter)]
> 
> this one is not a regex, do we still need to change it?
Indeed, it's essential to modify this aspect, especially since we're
encountering warnings when compiling the kernel with Python 3.12.

The choice between using an 'r'-prefixed string or manually escaping
each backslash is largely a matter of preference. It's worth noting that
the 'r' prefix is not only commonly employed for regular expressions but
also in contexts where backslashes should be treated as literal
characters rather than escape sequences.

Should I send another patch escaping backslash for non regex string
literals?
>>              date = subprocess.run(cmd, cwd=linuxRoot,
>>                                    capture_output=True, check=True)
>>              return date.stdout.decode().rstrip()
>> @@ -496,7 +496,7 @@ HELPERS
>>                              date=lastUpdate))
>>
>>      def print_footer(self):
>> -        footer = '''
>> +        footer = r'''
> 
> same here, not a regex string
> 
>>  EXAMPLES
>>  ========
>>
>> @@ -598,7 +598,7 @@ SEE ALSO
>>              one_arg = '{}{}'.format(comma, a['type'])
>>              if a['name']:
>>                  if a['star']:
>> -                    one_arg += ' {}**\ '.format(a['star'].replace('*', '\\*'))
>> +                    one_arg += r' {}**\ '.format(a['star'].replace('*', '\\*'))
> 
> and this one as well?
> 
>>                  else:
>>                      one_arg += '** '
>>                  one_arg += '*{}*\\ **'.format(a['name'])
>> --
>> 2.41.0
>>


